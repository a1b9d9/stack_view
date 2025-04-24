/// PutMinMaxSize Class
/// The PutMinMaxSize class provides a utility method to constrain a given size within specified minimum and maximum limits.
///
/// Method: putMinMaxSize
/// static double putMinMaxSize({
/// required double size,
/// required double min,
/// required double max,
/// })
/// Description:
/// The putMinMaxSize method takes a size value and ensures it falls within the range specified by min and max. If the size is less than min, it returns min. If the size is greater than max, it returns max. Otherwise, it returns the original size.
///
/// Parameters:
/// size (double): The size value to be constrained.
/// min (double): The minimum allowable value.
/// max (double): The maximum allowable value.
/// Returns:
/// double: The constrained size value, ensuring it is within the [min, max] range.
library;

class PutMinMaxSize {
  static double putMinMaxSize({
    required double size,
    required double min,
    required double max,
  }) {
    if (size < min) {
      return min;
    } else if (size > max) {
      return max;
    } else {
      return size;
    }
  }
}
