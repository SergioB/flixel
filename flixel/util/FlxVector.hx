package flixel.util;

/**
 * 2-dimensional vector class
 */
class FlxVector extends FlxPoint
{
	public static inline var EPSILON:Float = 0.0000001;
	public static inline var EPSILON_SQUARED:Float = EPSILON * EPSILON;
	
	private static var _vector1:FlxVector = new FlxVector();
	private static var _vector2:FlxVector = new FlxVector();
	private static var _vector3:FlxVector = new FlxVector();
	
	/**
	 * Instantiate a new point object.
	 * @param	X		The X-coordinate of the point in space.
	 * @param	Y		The Y-coordinate of the point in space.
	 */
	public function new(X:Float = 0, Y:Float = 0)
	{
		super(X, Y);
	}
	
	/**
	 * Set the coordinates of this point object.
	 * @param	X		The X-coordinate of the point in space.
	 * @param	Y		The Y-coordinate of the point in space.
	 */
	override public function set(X:Float = 0, Y:Float = 0):FlxVector
	{
		x = X;
		y = Y;
		return this;
	}
	
	/**
	 * scaling of the vector
	 * @param	k - scale coefficient
	 * @return	scaled vector
	 */
	inline public function scale(k:Float):FlxVector
	{
		x *= k;
		y *= k;
		return this;
	}
	
	/**
	 * returns scaled copy of this vector 
	 * @param	k - scale coefficient
	 * @return	scaled vector
	 */
	inline public function scaleNew(k:Float):FlxVector
	{
		return clone().scale(k);
	}
	
	/**
	 * vector addition
	 * @param	v	vector to add
	 * @return	addition result
	 */
	inline public function add(v:FlxVector):FlxVector
	{
		x += v.x;
		y += v.y;
		return this;
	}
	
	/**
	 * return new vector which equals to sum of this vector and passed v vector
	 * @param	v	vector to add
	 * @return	addition result
	 */
	inline public function addNew(v:FlxVector):FlxVector
	{
		return clone().add(v);
	}
	
	/**
	 * vector substraction
	 * @param	v	vector to substract
	 * @return	substraction result
	 */
	inline public function substract(v:FlxVector):FlxVector
	{
		x -= v.x;
		y -= v.y;
		return this;
	}
	
	/**
	 * returns new vector which is result of substraction of v vector from this vector
	 * @param	v	vector to substract
	 * @return	substraction result
	 */
	inline public function substractNew(v:FlxVector):FlxVector
	{
		return clone().substract(v);
	}
	
	/**
	 * dot product
	 * @param	v	vector to multiply
	 * @return	dot product of two vectors
	 */
	inline public function dotProduct(v:FlxVector):Float
	{
		return x * v.x + y * v.y;
	}
	
	/**
	 * dot product of vectors with normalization of the second vector
	 * @param	v	vector to multiply
	 * @return	dot product of two vectors
	 */
	inline public function dotProdWithNormalizing(v:FlxVector):Float
	{
		var normalized:FlxVector = v.clone(_vector1).normalize();
		return dotProduct(normalized);
	}
	
	/**
	 * check the perpendicularity of two vectors
	 * @param	v	vector to check
	 * @return	true - if they are perpendicular
	 */
	inline public function isPerpendicular(v:FlxVector):Bool
	{
		return Math.abs(this.dotProduct(v)) < EPSILON_SQUARED;
	}
	
	/**
	 * find the length of cross product
	 * @param	v	vector to multiply
	 * @return	the length of cross product of two vectors
	 */
	inline public function crossProductLength(v:FlxVector):Float
	{
		return x * v.y - y * v.x;
	}
	
	/**
	 * Check for parallelism of the vectors
	 * @param	v	vector to check
	 * @return	true - if they are parallel
	 */
	inline public function isParallel(v:FlxVector):Bool
	{
		return Math.abs(this.crossProductLength(v)) < EPSILON_SQUARED;
	}
	
	/**
	 * Checking the vector for zero-length
	 * @return	true - if the vector is zero
	 */
	inline public function isZero():Bool
	{
		return (Math.abs(x) < EPSILON && Math.abs(y) < EPSILON);
	}
	
	/**
	 * Vector reset
	 */
	inline public function zero():FlxVector
	{
		x = y = 0;
		return this;
	}
	
	/**
	 * Normalization of the vector (reduction to unit length)
	 */
	public function normalize():FlxVector
	{
		if (isZero()) 
		{
			x = 1;
			return this;
		}
		return this.scale(1 / this.length);
	}
	
	/**
	 * The horizontal component of the unit vector
	 */
	public var dx(get, never):Float;
	
	inline private function get_dx():Float
	{
		if (isZero()) return 0;
		
		return x / this.length;
	}
	
	/**
	 * The vertical component of the unit vector
	 */
	public var dy(get, never):Float;
	
	inline private function get_dy():Float
	{
		if (isZero()) return 0;
		
		return y / this.length;
	}
	
	/**
	 * Check the vector for unit length
	 */
	inline public function isNormalized():Bool
	{
		return Math.abs(lengthSquared - 1) < EPSILON_SQUARED;
	}
	
	/**
	 * Checking for equality of vectors
	 * @return	true - if the vectors are equal
	 */
	inline public function equals(v:FlxVector):Bool
	{
		return (Math.abs(x - v.x) < EPSILON && Math.abs(y - v.y) < EPSILON);
	}
	
	/**
	 * Length of the vector
	 */
	public var length(get, set):Float;
	
	inline private function get_length():Float
	{
		return Math.sqrt(lengthSquared);
	}
	
	inline private function set_length(l:Float):Float
	{
		var a:Float = this.radians;
		x = l * Math.cos(a);
		y = l * Math.sin(a);
		return l;
	}
	
	/**
	 * length of the vector squared
	 */
	public var lengthSquared(get, never):Float;
	
	inline private function get_lengthSquared():Float
	{
		return x * x + y * y;
	}
	
	/**
	 * The angle formed by the vector with the horizontal axis (in degrees)
	 */
	public var degrees(get, set):Float;
	
	inline private function get_degrees():Float
	{
		return radians * FlxAngle.TO_DEG;
	}
	
	inline private function set_degrees(degs:Float):Float
	{
		radians = degs * FlxAngle.TO_RAD;
		return degs;
	}
	
	/**
	 * The angle formed by the vector with the horizontal axis (in radians)
	 */
	public var radians(get, set):Float;
	
	private function get_radians():Float
	{
		if (isZero()) return 0;
		
		return Math.atan2(y, x);
	}
	
	inline private function set_radians(rads:Float):Float
	{
		var len:Float = this.length;
		
		x = len * Math.cos(rads);
		y = len * Math.sin(rads);
		return rads;
	}
	
	/**
	 * Rotate the vector for a given angle
	 * @param	rads	angle to rotate
	 * @return	rotated vector
	 */
	inline public function rotateByRadians(rads:Float):FlxVector
	{
		var s:Float = Math.sin(rads);
		var c:Float = Math.cos(rads);
		var tempX:Float = x;
		
		x = tempX * c - y * s;
		y = tempX * s + y * c;
		
		return this;
	}
	
	/**
	 * Rotate the vector for a given angle
	 * @param	rads	angle to rotate
	 * @return	rotated vector
	 */
	inline public function rotateByDegrees(degs:Float):FlxVector
	{
		return rotateByRadians(degs * FlxAngle.TO_RAD);
	}
	
	/**
	 * Rotate the vector vector with the values of sine and cosine of the angle of rotation
	 * @param	sin	the value of sine of the angle of rotation
	 * @param	cos	the value of cosine of the angle of rotation
	 * @return	rotated vector
	 */
	inline public function rotateWithTrig(sin:Float, cos:Float):FlxVector
	{
		var tempX:Float = x;
		x = tempX * cos - y * sin;
		y = tempX * sin + y * cos;
		return this;
	}
		
	/**
	 * Right normal of the vector
	 */
	inline public function rightNormal(vec:FlxVector = null):FlxVector 
	{ 
		if (vec == null)
		{
			vec = new FlxVector();
		}
		vec.set( -y, x);
		return vec; 
	}
		
	/**
	 * The horizontal component of the right normal of the vector
	 */
	public var rx(get, never):Float;
	
	inline private function get_rx():Float
	{
		return -y;
	}
		
	/**
	 * The vertical component of the right normal of the vector
	 */
	public var ry(get, never):Float;
	
	inline private function get_ry():Float
	{
		return x;
	}
        
	/**
	 * Left normal of the vector
	 */
	inline public function leftNormal(vec:FlxVector = null):FlxVector 
	{ 
		if (vec == null)
		{
			vec = new FlxVector();
		}
		vec.set(y, -x);
		return vec; 
	}
		
	/**
	 * The horizontal component of the left normal of the vector
	 */
	public var lx(get, never):Float;
	
	inline private function get_lx():Float
	{
		return y;
	}
		
	/**
	 * The vertical component of the left normal of the vector
	 */
	public var ly(get, never):Float;
	
	inline private function get_ly():Float
	{
		return -x;
	}
        
	/**
	 * Change direction of the vector to opposite
	 */
	inline public function negate():FlxVector 
	{ 
		x *= -1;
		y *= -1;
		return this;
	}
	
	inline public function negateNew():FlxVector
	{
		return this.clone().negate();
	}
	
	/**
	 * The projection of this vector to vector that is passed as an argument 
	 * (without modifying the original Vector!)
	 * @param	v	vector to project
	 * @param	proj	optional argument - result vector
	 * @return	projection of the vector
	 */
	inline public function projectTo(v:FlxVector, proj:FlxVector = null):FlxVector
	{
		var dp:Float = this.dotProduct(v);
		var lenSq:Float = v.lengthSquared;
		
		if (proj == null)
		{
			proj = new FlxVector();
		}
		
		return proj.set(dp * v.x / lenSq, dp * v.y / lenSq);
	}
		
	/**
	 * Projecting this vector on the normalized vector v
	 * @param	v	this vector has to be normalized, ie have unit length
	 * @param	proj	optional argument - result vector
	 * @return	projection of the vector
	 */
	inline public function projectToNormalized(v:FlxVector, proj:FlxVector = null):FlxVector
	{
		var dp:Float = this.dotProduct(v);
		
		if (proj == null)
		{
			proj = new FlxVector();
		}
		
		return proj.set(dp * v.x, dp * v.y);
	}
		
	/**
	 * perproduct - dot product of left the normal vector and vector v
	 */
	inline public function perpProduct(v:FlxVector):Float
	{
		return this.lx * v.x + this.ly * v.y;
	}
	
	/**
	 * Find the ratio between the perpProducts of this vector and v vector. This helps to find the intersection point
	 * @param	a	start point of the vector
	 * @param	b	start point of the v vector
	 * @param	v	the second vector
	 * @return	the ratio between the perpProducts of this vector and v vector
	 */
	public function ratio(a:FlxVector, b:FlxVector, v:FlxVector):Float
	{
		if (this.isParallel(v)) return Math.NaN;
		if (this.lengthSquared < EPSILON_SQUARED || v.lengthSquared < EPSILON_SQUARED) return Math.NaN;
		
		_vector1 = b.clone(_vector1);
		_vector1.substract(a);
		
		return _vector1.perpProduct(v) / this.perpProduct(v);
	}
		
	/**
	 * Finding the point of intersection of vectors
	 * @param	a	start point of the vector
	 * @param	b	start point of the v vector
	 * @param	v	the second vector
	 * @return the point of intersection of vectors
	 */
	public function findIntersection(a:FlxVector, b:FlxVector, v:FlxVector, intersection:FlxVector = null):FlxVector
	{
		var t:Float = this.ratio(a, b, v);
		
		if (intersection == null)
		{
			intersection = new FlxVector();
		}
		
		if (Math.isNaN(t))
		{
			return intersection.set(Math.NaN, Math.NaN);
		}
		
		return intersection.set(a.x + t * this.x, a.y + t * this.y);
	}
	
	/**
	 * Finding the point of intersection of vectors if it is in the "bounds" of the vectors
	 * @param	a	start point of the vector
	 * @param	b	start point of the v vector
	 * @param	v	the second vector
	 * @return the point of intersection of vectors if it is in the "bounds" of the vectors
	 */
	public function findIntersectionInBounds(a:FlxVector, b:FlxVector, v:FlxVector, intersection:FlxVector = null):FlxVector
	{
		if (intersection == null)
		{
			intersection = new FlxVector();
		}
		
		var t1:Float = this.ratio(a, b, v);
		var t2:Float = v.ratio(b, a, this);
		if (!Math.isNaN(t1) && !Math.isNaN(t2) && t1 > 0 && t1 <= 1 && t2 > 0 && t2 <= 1)
		{
			return intersection.set(a.x + t1 * this.x, a.y + t1 * this.y);
		}
		
		return intersection.set(Math.NaN, Math.NaN);
	}
	
	/**
	 * Length limit of the vector
	 * @param	max	maximum length of this vector
	 */
	inline public function truncate(max:Float):FlxVector
	{
		this.length = Math.min(max, this.length);
		return this;
	}
	
	/**
	 * The angle between vectors
	 * @param	v	second vector, which we find the angle
	 * @return	the angle in radians
	 */
	inline public function radiansBetween(v:FlxVector):Float
	{
		_vector1 = this.clone(_vector1);
		_vector2 = this.clone(_vector2);
		
		if (!this.isNormalized())
		{
			_vector1.normalize();
		}
		if (!v.isNormalized())
		{
			_vector2.normalize();
		}
		return Math.acos(_vector1.dotProduct(_vector2));
	}
	
	/**
	 * The angle between vectors
	 * @param	v	second vector, which we find the angle
	 * @return	the angle in radians
	 */
	inline public function degreesBetween(v:FlxVector):Float
	{
		return radiansBetween(v) * FlxAngle.TO_DEG;
	}
	
	/**
	 * The sign of half-plane of point with respect to the vector through the a and b points
	 * @param	a	start point of the wall-vector
	 * @param	b	end point of the wall-vector
	 */
	public function sign(a:FlxVector, b:FlxVector):Int
	{
		var signFl:Float = (a.x - this.x) * (b.y - this.y) - (a.y - this.y) * (b.x - this.x);
		if (signFl == 0)
		{
			return 0;
		}
		return Math.round(signFl / Math.abs(signFl));
	}
	
	/**
	 * The distance between points
	 */
	inline public function dist(v:FlxVector):Float
	{
		return Math.sqrt(distSquared(v));
	}
	
	/**
	 * The squared distance between points
	 */
	inline public function distSquared(v:FlxVector):Float
	{
		var dx:Float = v.x - x;
		var dy:Float = v.y - y;
		return (dx * dx + dy * dy);
	}
		
	/**
	 * Reflect the vector with respect to the normal of the "wall"
	 * @param normal left normal of the "wall". It must be normalized (no checks)
	 * @param bounceCoeff bounce coefficient (0 <= bounceCoeff <= 1)
	 * @return reflected vector (angle of incidence equals to angle of reflection)
	 */
	inline public function bounce(normal:FlxVector, bounceCoeff:Float = 1):FlxVector
	{
		var d:Float = (1 + bounceCoeff) * this.dotProduct(normal);
		x -= d * normal.x;
		y -= d * normal.y;
		return this;
	}
	
	/**
	 * Reflect the vector with respect to the normal. This operation takes "friction" into account
	 * @param normal left normal of the "wall". It must be normalized (no checks)
	 * @param bounceCoeff bounce coefficient (0 <= bounceCoeff <= 1)
	 * @param friction friction coefficient
	 * @return reflected vector
	 */
	inline public function bounceWithFriction(normal:FlxVector, bounceCoeff:Float = 1, friction:Float = 0):FlxVector
	{
		var p1:FlxVector = this.projectToNormalized(normal.rightNormal(_vector3), _vector1);
		var p2:FlxVector = this.projectToNormalized(normal, _vector2);
		var bounceX:Float = -p2.x;
		var bounceY:Float = -p2.y;
		var frictionX:Float = p1.x;
		var frictionY:Float = p1.y;
		this.x = bounceX * bounceCoeff + frictionX * friction;
		this.y = bounceY * bounceCoeff + frictionY * friction;
		return this;
	}
	
	/**
	 * Checking the validity of the vector
	 * @return	true - if the vector is valid
	 */
	inline public function isValid():Bool
	{ 
		return !Math.isNaN(x) && !Math.isNaN(y) && Math.isFinite(x) && Math.isFinite(y); 
	}
	
	/**
	 * Copies this vector
	 * @param	vec		optional vector to copy this vector to
	 * @return	copy	of this vector
	 */
	inline public function clone(vec:FlxVector = null):FlxVector
	{
		if (vec == null)
		{
			vec = new FlxVector();
		}
		
		vec.x = x;
		vec.y = y;
		
		return vec;
	}
}