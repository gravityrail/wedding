class CreateDistanceFunction < ActiveRecord::Migration
  def self.up
    execute <<-ENDSQL
      CREATE FUNCTION GET_DISTANCE
          (alat FLOAT, alon FLOAT, lat FLOAT, lon FLOAT)
      RETURNS FLOAT AS
      $$
      DECLARE
          radius_earth FLOAT;
          radian_lat FLOAT;
          radian_lon FLOAT;
          distance_v FLOAT;
          distance_h FLOAT;
          distance FLOAT;
      BEGIN
          -- Insert earth radius
          SELECT INTO radius_earth 6378.137;

          -- Calculate difference between lat and alat
          SELECT INTO radian_lat radians(lat - alat);

          -- Calculate difference between lon and alon
          SELECT INTO radian_lon radians(lon - alon);

          -- Calculate vertical distance
          SELECT INTO distance_v (radius_earth * radian_lat);

          -- Calculate horizontal distance
          SELECT INTO distance_h (cos(radians(alat)) * radius_earth * radian_lon);

          -- Calculate distance(km) and convert it to distance(meter)
          SELECT INTO distance sqrt(pow(distance_h,2) + pow(distance_v,2)) * 1000;

          -- Returns distance
          RETURN DISTANCE;
      END;
      $$ language plpgsql;
    ENDSQL
  end

  def self.down
    execute "drop function GET_DISTANCE(alat FLOAT, alon FLOAT, lat FLOAT, lon FLOAT)"
  end
end
