çĘ
ľ
9
Add
x"T
y"T
z"T"
Ttype:
2	
x
Assign
ref"T

value"T

output_ref"T"	
Ttype"
validate_shapebool("
use_lockingbool(
{
BiasAdd

value"T	
bias"T
output"T"
Ttype:
2	"-
data_formatstringNHWC:
NHWCNCHW
h
ConcatV2
values"T*N
axis"Tidx
output"T"
Nint(0"	
Ttype"
Tidxtype0:
2	
8
Const
output"dtype"
valuetensor"
dtypetype
Č
Conv2D

input"T
filter"T
output"T"
Ttype:
2"
strides	list(int)"
use_cudnn_on_gpubool(""
paddingstring:
SAMEVALID"-
data_formatstringNHWC:
NHWCNCHW
W

ExpandDims

input"T
dim"Tdim
output"T"	
Ttype"
Tdimtype0:
2	
S
HistogramSummary
tag
values"T
summary"
Ttype0:
2		
.
Identity

input"T
output"T"	
Ttype
o
MatMul
a"T
b"T
product"T"
transpose_abool( "
transpose_bbool( "
Ttype:

2
Ĺ
MaxPool

input"T
output"T"
Ttype0:
2		"
ksize	list(int)(0"
strides	list(int)(0""
paddingstring:
SAMEVALID"-
data_formatstringNHWC:
NHWCNCHW
8
MergeSummary
inputs*N
summary"
Nint(0
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(
<
Mul
x"T
y"T
z"T"
Ttype:
2	

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:

Prod

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( "
Ttype:
2	"
Tidxtype0:
2	
A
Relu
features"T
activations"T"
Ttype:
2		
[
Reshape
tensor"T
shape"Tshape
output"T"	
Ttype"
Tshapetype0:
2	
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
-
Rsqrt
x"T
y"T"
Ttype:	
2
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
P
Shape

input"T
output"out_type"	
Ttype"
out_typetype0:
2	
H
ShardedFilename
basename	
shard

num_shards
filename
a
Slice

input"T
begin"Index
size"Index
output"T"	
Ttype"
Indextype:
2	
8
Softmax
logits"T
softmax"T"
Ttype:
2
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
5
Sub
x"T
y"T
z"T"
Ttype:
	2	
c
TopKV2

input"T
k
values"T
indices"
sortedbool("
Ttype:
2		

TruncatedNormal

shape"T
output"dtype"
seedint "
seed2int "
dtypetype:
2"
Ttype:
2	
s

VariableV2
ref"dtype"
shapeshape"
dtypetype"
	containerstring "
shared_namestring "serve*	1.3.0-rc22v1.3.0-rc2-0-g2784b1cŮ
~
PlaceholderPlaceholder*$
shape:˙˙˙˙˙˙˙˙˙H*
dtype0*/
_output_shapes
:˙˙˙˙˙˙˙˙˙H
R
Placeholder_1Placeholder*
dtype0*
_output_shapes
:*
shape:
R
Placeholder_2Placeholder*
shape:*
dtype0*
_output_shapes
:
R
Placeholder_3Placeholder*
shape:*
dtype0*
_output_shapes
:
Ť
0conv1/weights/Initializer/truncated_normal/shapeConst* 
_class
loc:@conv1/weights*%
valueB"            *
dtype0*
_output_shapes
:

/conv1/weights/Initializer/truncated_normal/meanConst* 
_class
loc:@conv1/weights*
valueB
 *    *
dtype0*
_output_shapes
: 

1conv1/weights/Initializer/truncated_normal/stddevConst* 
_class
loc:@conv1/weights*
valueB
 *
×#<*
dtype0*
_output_shapes
: 
ř
:conv1/weights/Initializer/truncated_normal/TruncatedNormalTruncatedNormal0conv1/weights/Initializer/truncated_normal/shape*
dtype0*&
_output_shapes
:*

seed *
T0* 
_class
loc:@conv1/weights*
seed2 
÷
.conv1/weights/Initializer/truncated_normal/mulMul:conv1/weights/Initializer/truncated_normal/TruncatedNormal1conv1/weights/Initializer/truncated_normal/stddev*
T0* 
_class
loc:@conv1/weights*&
_output_shapes
:
ĺ
*conv1/weights/Initializer/truncated_normalAdd.conv1/weights/Initializer/truncated_normal/mul/conv1/weights/Initializer/truncated_normal/mean*
T0* 
_class
loc:@conv1/weights*&
_output_shapes
:
ł
conv1/weights
VariableV2*
shared_name * 
_class
loc:@conv1/weights*
	container *
shape:*
dtype0*&
_output_shapes
:
Ő
conv1/weights/AssignAssignconv1/weights*conv1/weights/Initializer/truncated_normal*
T0* 
_class
loc:@conv1/weights*
validate_shape(*&
_output_shapes
:*
use_locking(

conv1/weights/readIdentityconv1/weights*&
_output_shapes
:*
T0* 
_class
loc:@conv1/weights
p
conv1/convolution/ShapeConst*%
valueB"            *
dtype0*
_output_shapes
:
p
conv1/convolution/dilation_rateConst*
_output_shapes
:*
valueB"      *
dtype0
Í
conv1/convolutionConv2DPlaceholderconv1/weights/read*
T0*
data_formatNHWC*
strides
*
use_cudnn_on_gpu(*
paddingSAME*/
_output_shapes
:˙˙˙˙˙˙˙˙˙H

&conv1/BatchNorm/beta/Initializer/zerosConst*'
_class
loc:@conv1/BatchNorm/beta*
valueB*    *
dtype0*
_output_shapes
:
Š
conv1/BatchNorm/beta
VariableV2*
	container *
shape:*
dtype0*
_output_shapes
:*
shared_name *'
_class
loc:@conv1/BatchNorm/beta
Ú
conv1/BatchNorm/beta/AssignAssignconv1/BatchNorm/beta&conv1/BatchNorm/beta/Initializer/zeros*
validate_shape(*
_output_shapes
:*
use_locking(*
T0*'
_class
loc:@conv1/BatchNorm/beta

conv1/BatchNorm/beta/readIdentityconv1/BatchNorm/beta*'
_class
loc:@conv1/BatchNorm/beta*
_output_shapes
:*
T0
Ş
-conv1/BatchNorm/moving_mean/Initializer/zerosConst*.
_class$
" loc:@conv1/BatchNorm/moving_mean*
valueB*    *
dtype0*
_output_shapes
:
ˇ
conv1/BatchNorm/moving_mean
VariableV2*
shared_name *.
_class$
" loc:@conv1/BatchNorm/moving_mean*
	container *
shape:*
dtype0*
_output_shapes
:
ö
"conv1/BatchNorm/moving_mean/AssignAssignconv1/BatchNorm/moving_mean-conv1/BatchNorm/moving_mean/Initializer/zeros*
use_locking(*
T0*.
_class$
" loc:@conv1/BatchNorm/moving_mean*
validate_shape(*
_output_shapes
:

 conv1/BatchNorm/moving_mean/readIdentityconv1/BatchNorm/moving_mean*
T0*.
_class$
" loc:@conv1/BatchNorm/moving_mean*
_output_shapes
:
ą
0conv1/BatchNorm/moving_variance/Initializer/onesConst*
dtype0*
_output_shapes
:*2
_class(
&$loc:@conv1/BatchNorm/moving_variance*
valueB*  ?
ż
conv1/BatchNorm/moving_variance
VariableV2*
shared_name *2
_class(
&$loc:@conv1/BatchNorm/moving_variance*
	container *
shape:*
dtype0*
_output_shapes
:

&conv1/BatchNorm/moving_variance/AssignAssignconv1/BatchNorm/moving_variance0conv1/BatchNorm/moving_variance/Initializer/ones*
T0*2
_class(
&$loc:@conv1/BatchNorm/moving_variance*
validate_shape(*
_output_shapes
:*
use_locking(
Ş
$conv1/BatchNorm/moving_variance/readIdentityconv1/BatchNorm/moving_variance*2
_class(
&$loc:@conv1/BatchNorm/moving_variance*
_output_shapes
:*
T0
d
conv1/BatchNorm/batchnorm/add/yConst*
valueB
 *o:*
dtype0*
_output_shapes
: 

conv1/BatchNorm/batchnorm/addAdd$conv1/BatchNorm/moving_variance/readconv1/BatchNorm/batchnorm/add/y*
T0*
_output_shapes
:
l
conv1/BatchNorm/batchnorm/RsqrtRsqrtconv1/BatchNorm/batchnorm/add*
T0*
_output_shapes
:

conv1/BatchNorm/batchnorm/mulMulconv1/convolutionconv1/BatchNorm/batchnorm/Rsqrt*
T0*/
_output_shapes
:˙˙˙˙˙˙˙˙˙H

conv1/BatchNorm/batchnorm/mul_1Mul conv1/BatchNorm/moving_mean/readconv1/BatchNorm/batchnorm/Rsqrt*
T0*
_output_shapes
:

conv1/BatchNorm/batchnorm/subSubconv1/BatchNorm/beta/readconv1/BatchNorm/batchnorm/mul_1*
T0*
_output_shapes
:

conv1/BatchNorm/batchnorm/add_1Addconv1/BatchNorm/batchnorm/mulconv1/BatchNorm/batchnorm/sub*
T0*/
_output_shapes
:˙˙˙˙˙˙˙˙˙H
m

conv1/ReluReluconv1/BatchNorm/batchnorm/add_1*/
_output_shapes
:˙˙˙˙˙˙˙˙˙H*
T0
ą
pool1/MaxPoolMaxPool
conv1/Relu*
data_formatNHWC*
strides
*
ksize
*
paddingVALID*/
_output_shapes
:˙˙˙˙˙˙˙˙˙$*
T0
Ť
0conv2/weights/Initializer/truncated_normal/shapeConst* 
_class
loc:@conv2/weights*%
valueB"            *
dtype0*
_output_shapes
:

/conv2/weights/Initializer/truncated_normal/meanConst*
_output_shapes
: * 
_class
loc:@conv2/weights*
valueB
 *    *
dtype0

1conv2/weights/Initializer/truncated_normal/stddevConst* 
_class
loc:@conv2/weights*
valueB
 *
×#<*
dtype0*
_output_shapes
: 
ř
:conv2/weights/Initializer/truncated_normal/TruncatedNormalTruncatedNormal0conv2/weights/Initializer/truncated_normal/shape*
T0* 
_class
loc:@conv2/weights*
seed2 *
dtype0*&
_output_shapes
:*

seed 
÷
.conv2/weights/Initializer/truncated_normal/mulMul:conv2/weights/Initializer/truncated_normal/TruncatedNormal1conv2/weights/Initializer/truncated_normal/stddev*&
_output_shapes
:*
T0* 
_class
loc:@conv2/weights
ĺ
*conv2/weights/Initializer/truncated_normalAdd.conv2/weights/Initializer/truncated_normal/mul/conv2/weights/Initializer/truncated_normal/mean*
T0* 
_class
loc:@conv2/weights*&
_output_shapes
:
ł
conv2/weights
VariableV2* 
_class
loc:@conv2/weights*
	container *
shape:*
dtype0*&
_output_shapes
:*
shared_name 
Ő
conv2/weights/AssignAssignconv2/weights*conv2/weights/Initializer/truncated_normal*
use_locking(*
T0* 
_class
loc:@conv2/weights*
validate_shape(*&
_output_shapes
:

conv2/weights/readIdentityconv2/weights*&
_output_shapes
:*
T0* 
_class
loc:@conv2/weights
p
conv2/convolution/ShapeConst*%
valueB"            *
dtype0*
_output_shapes
:
p
conv2/convolution/dilation_rateConst*
valueB"      *
dtype0*
_output_shapes
:
Ď
conv2/convolutionConv2Dpool1/MaxPoolconv2/weights/read*
paddingSAME*/
_output_shapes
:˙˙˙˙˙˙˙˙˙$*
T0*
data_formatNHWC*
strides
*
use_cudnn_on_gpu(

&conv2/BatchNorm/beta/Initializer/zerosConst*'
_class
loc:@conv2/BatchNorm/beta*
valueB*    *
dtype0*
_output_shapes
:
Š
conv2/BatchNorm/beta
VariableV2*
shape:*
dtype0*
_output_shapes
:*
shared_name *'
_class
loc:@conv2/BatchNorm/beta*
	container 
Ú
conv2/BatchNorm/beta/AssignAssignconv2/BatchNorm/beta&conv2/BatchNorm/beta/Initializer/zeros*
use_locking(*
T0*'
_class
loc:@conv2/BatchNorm/beta*
validate_shape(*
_output_shapes
:

conv2/BatchNorm/beta/readIdentityconv2/BatchNorm/beta*
T0*'
_class
loc:@conv2/BatchNorm/beta*
_output_shapes
:
Ş
-conv2/BatchNorm/moving_mean/Initializer/zerosConst*.
_class$
" loc:@conv2/BatchNorm/moving_mean*
valueB*    *
dtype0*
_output_shapes
:
ˇ
conv2/BatchNorm/moving_mean
VariableV2*
shared_name *.
_class$
" loc:@conv2/BatchNorm/moving_mean*
	container *
shape:*
dtype0*
_output_shapes
:
ö
"conv2/BatchNorm/moving_mean/AssignAssignconv2/BatchNorm/moving_mean-conv2/BatchNorm/moving_mean/Initializer/zeros*
use_locking(*
T0*.
_class$
" loc:@conv2/BatchNorm/moving_mean*
validate_shape(*
_output_shapes
:

 conv2/BatchNorm/moving_mean/readIdentityconv2/BatchNorm/moving_mean*
T0*.
_class$
" loc:@conv2/BatchNorm/moving_mean*
_output_shapes
:
ą
0conv2/BatchNorm/moving_variance/Initializer/onesConst*2
_class(
&$loc:@conv2/BatchNorm/moving_variance*
valueB*  ?*
dtype0*
_output_shapes
:
ż
conv2/BatchNorm/moving_variance
VariableV2*
dtype0*
_output_shapes
:*
shared_name *2
_class(
&$loc:@conv2/BatchNorm/moving_variance*
	container *
shape:

&conv2/BatchNorm/moving_variance/AssignAssignconv2/BatchNorm/moving_variance0conv2/BatchNorm/moving_variance/Initializer/ones*
_output_shapes
:*
use_locking(*
T0*2
_class(
&$loc:@conv2/BatchNorm/moving_variance*
validate_shape(
Ş
$conv2/BatchNorm/moving_variance/readIdentityconv2/BatchNorm/moving_variance*
T0*2
_class(
&$loc:@conv2/BatchNorm/moving_variance*
_output_shapes
:
d
conv2/BatchNorm/batchnorm/add/yConst*
valueB
 *o:*
dtype0*
_output_shapes
: 

conv2/BatchNorm/batchnorm/addAdd$conv2/BatchNorm/moving_variance/readconv2/BatchNorm/batchnorm/add/y*
T0*
_output_shapes
:
l
conv2/BatchNorm/batchnorm/RsqrtRsqrtconv2/BatchNorm/batchnorm/add*
T0*
_output_shapes
:

conv2/BatchNorm/batchnorm/mulMulconv2/convolutionconv2/BatchNorm/batchnorm/Rsqrt*/
_output_shapes
:˙˙˙˙˙˙˙˙˙$*
T0

conv2/BatchNorm/batchnorm/mul_1Mul conv2/BatchNorm/moving_mean/readconv2/BatchNorm/batchnorm/Rsqrt*
_output_shapes
:*
T0

conv2/BatchNorm/batchnorm/subSubconv2/BatchNorm/beta/readconv2/BatchNorm/batchnorm/mul_1*
T0*
_output_shapes
:

conv2/BatchNorm/batchnorm/add_1Addconv2/BatchNorm/batchnorm/mulconv2/BatchNorm/batchnorm/sub*
T0*/
_output_shapes
:˙˙˙˙˙˙˙˙˙$
m

conv2/ReluReluconv2/BatchNorm/batchnorm/add_1*
T0*/
_output_shapes
:˙˙˙˙˙˙˙˙˙$
ą
pool2/MaxPoolMaxPool
conv2/Relu*/
_output_shapes
:˙˙˙˙˙˙˙˙˙*
T0*
data_formatNHWC*
strides
*
ksize
*
paddingVALID
ˇ
SPP_Layer/MaxPoolMaxPoolpool2/MaxPool*
T0*
data_formatNHWC*
strides
*
ksize
*
paddingSAME*/
_output_shapes
:˙˙˙˙˙˙˙˙˙
h
SPP_Layer/Flatten/ShapeShapeSPP_Layer/MaxPool*
_output_shapes
:*
T0*
out_type0
g
SPP_Layer/Flatten/Slice/beginConst*
dtype0*
_output_shapes
:*
valueB: 
f
SPP_Layer/Flatten/Slice/sizeConst*
valueB:*
dtype0*
_output_shapes
:
¨
SPP_Layer/Flatten/SliceSliceSPP_Layer/Flatten/ShapeSPP_Layer/Flatten/Slice/beginSPP_Layer/Flatten/Slice/size*
_output_shapes
:*
Index0*
T0
i
SPP_Layer/Flatten/Slice_1/beginConst*
valueB:*
dtype0*
_output_shapes
:
h
SPP_Layer/Flatten/Slice_1/sizeConst*
dtype0*
_output_shapes
:*
valueB:
Ž
SPP_Layer/Flatten/Slice_1SliceSPP_Layer/Flatten/ShapeSPP_Layer/Flatten/Slice_1/beginSPP_Layer/Flatten/Slice_1/size*
Index0*
T0*
_output_shapes
:
a
SPP_Layer/Flatten/ConstConst*
dtype0*
_output_shapes
:*
valueB: 

SPP_Layer/Flatten/ProdProdSPP_Layer/Flatten/Slice_1SPP_Layer/Flatten/Const*
T0*
_output_shapes
: *
	keep_dims( *

Tidx0
b
 SPP_Layer/Flatten/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 

SPP_Layer/Flatten/ExpandDims
ExpandDimsSPP_Layer/Flatten/Prod SPP_Layer/Flatten/ExpandDims/dim*

Tdim0*
T0*
_output_shapes
:
_
SPP_Layer/Flatten/concat/axisConst*
dtype0*
_output_shapes
: *
value	B : 
´
SPP_Layer/Flatten/concatConcatV2SPP_Layer/Flatten/SliceSPP_Layer/Flatten/ExpandDimsSPP_Layer/Flatten/concat/axis*
T0*
N*
_output_shapes
:*

Tidx0

SPP_Layer/Flatten/ReshapeReshapeSPP_Layer/MaxPoolSPP_Layer/Flatten/concat*
T0*
Tshape0*(
_output_shapes
:˙˙˙˙˙˙˙˙˙Ŕ
š
SPP_Layer/MaxPool_1MaxPoolpool2/MaxPool*/
_output_shapes
:˙˙˙˙˙˙˙˙˙*
T0*
data_formatNHWC*
strides
*
ksize
*
paddingSAME
l
SPP_Layer/Flatten_1/ShapeShapeSPP_Layer/MaxPool_1*
T0*
out_type0*
_output_shapes
:
i
SPP_Layer/Flatten_1/Slice/beginConst*
valueB: *
dtype0*
_output_shapes
:
h
SPP_Layer/Flatten_1/Slice/sizeConst*
valueB:*
dtype0*
_output_shapes
:
°
SPP_Layer/Flatten_1/SliceSliceSPP_Layer/Flatten_1/ShapeSPP_Layer/Flatten_1/Slice/beginSPP_Layer/Flatten_1/Slice/size*
Index0*
T0*
_output_shapes
:
k
!SPP_Layer/Flatten_1/Slice_1/beginConst*
valueB:*
dtype0*
_output_shapes
:
j
 SPP_Layer/Flatten_1/Slice_1/sizeConst*
valueB:*
dtype0*
_output_shapes
:
ś
SPP_Layer/Flatten_1/Slice_1SliceSPP_Layer/Flatten_1/Shape!SPP_Layer/Flatten_1/Slice_1/begin SPP_Layer/Flatten_1/Slice_1/size*
_output_shapes
:*
Index0*
T0
c
SPP_Layer/Flatten_1/ConstConst*
dtype0*
_output_shapes
:*
valueB: 

SPP_Layer/Flatten_1/ProdProdSPP_Layer/Flatten_1/Slice_1SPP_Layer/Flatten_1/Const*
T0*
_output_shapes
: *
	keep_dims( *

Tidx0
d
"SPP_Layer/Flatten_1/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 

SPP_Layer/Flatten_1/ExpandDims
ExpandDimsSPP_Layer/Flatten_1/Prod"SPP_Layer/Flatten_1/ExpandDims/dim*

Tdim0*
T0*
_output_shapes
:
a
SPP_Layer/Flatten_1/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ź
SPP_Layer/Flatten_1/concatConcatV2SPP_Layer/Flatten_1/SliceSPP_Layer/Flatten_1/ExpandDimsSPP_Layer/Flatten_1/concat/axis*

Tidx0*
T0*
N*
_output_shapes
:

SPP_Layer/Flatten_1/ReshapeReshapeSPP_Layer/MaxPool_1SPP_Layer/Flatten_1/concat*
T0*
Tshape0*(
_output_shapes
:˙˙˙˙˙˙˙˙˙
š
SPP_Layer/MaxPool_2MaxPoolpool2/MaxPool*
T0*
data_formatNHWC*
strides
	*
ksize
	*
paddingSAME*/
_output_shapes
:˙˙˙˙˙˙˙˙˙
l
SPP_Layer/Flatten_2/ShapeShapeSPP_Layer/MaxPool_2*
_output_shapes
:*
T0*
out_type0
i
SPP_Layer/Flatten_2/Slice/beginConst*
valueB: *
dtype0*
_output_shapes
:
h
SPP_Layer/Flatten_2/Slice/sizeConst*
valueB:*
dtype0*
_output_shapes
:
°
SPP_Layer/Flatten_2/SliceSliceSPP_Layer/Flatten_2/ShapeSPP_Layer/Flatten_2/Slice/beginSPP_Layer/Flatten_2/Slice/size*
Index0*
T0*
_output_shapes
:
k
!SPP_Layer/Flatten_2/Slice_1/beginConst*
valueB:*
dtype0*
_output_shapes
:
j
 SPP_Layer/Flatten_2/Slice_1/sizeConst*
valueB:*
dtype0*
_output_shapes
:
ś
SPP_Layer/Flatten_2/Slice_1SliceSPP_Layer/Flatten_2/Shape!SPP_Layer/Flatten_2/Slice_1/begin SPP_Layer/Flatten_2/Slice_1/size*
_output_shapes
:*
Index0*
T0
c
SPP_Layer/Flatten_2/ConstConst*
valueB: *
dtype0*
_output_shapes
:

SPP_Layer/Flatten_2/ProdProdSPP_Layer/Flatten_2/Slice_1SPP_Layer/Flatten_2/Const*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
d
"SPP_Layer/Flatten_2/ExpandDims/dimConst*
dtype0*
_output_shapes
: *
value	B : 

SPP_Layer/Flatten_2/ExpandDims
ExpandDimsSPP_Layer/Flatten_2/Prod"SPP_Layer/Flatten_2/ExpandDims/dim*

Tdim0*
T0*
_output_shapes
:
a
SPP_Layer/Flatten_2/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ź
SPP_Layer/Flatten_2/concatConcatV2SPP_Layer/Flatten_2/SliceSPP_Layer/Flatten_2/ExpandDimsSPP_Layer/Flatten_2/concat/axis*

Tidx0*
T0*
N*
_output_shapes
:

SPP_Layer/Flatten_2/ReshapeReshapeSPP_Layer/MaxPool_2SPP_Layer/Flatten_2/concat*
T0*
Tshape0*'
_output_shapes
:˙˙˙˙˙˙˙˙˙@
š
SPP_Layer/MaxPool_3MaxPoolpool2/MaxPool*
ksize
*
paddingSAME*/
_output_shapes
:˙˙˙˙˙˙˙˙˙*
T0*
data_formatNHWC*
strides

l
SPP_Layer/Flatten_3/ShapeShapeSPP_Layer/MaxPool_3*
out_type0*
_output_shapes
:*
T0
i
SPP_Layer/Flatten_3/Slice/beginConst*
valueB: *
dtype0*
_output_shapes
:
h
SPP_Layer/Flatten_3/Slice/sizeConst*
valueB:*
dtype0*
_output_shapes
:
°
SPP_Layer/Flatten_3/SliceSliceSPP_Layer/Flatten_3/ShapeSPP_Layer/Flatten_3/Slice/beginSPP_Layer/Flatten_3/Slice/size*
_output_shapes
:*
Index0*
T0
k
!SPP_Layer/Flatten_3/Slice_1/beginConst*
_output_shapes
:*
valueB:*
dtype0
j
 SPP_Layer/Flatten_3/Slice_1/sizeConst*
valueB:*
dtype0*
_output_shapes
:
ś
SPP_Layer/Flatten_3/Slice_1SliceSPP_Layer/Flatten_3/Shape!SPP_Layer/Flatten_3/Slice_1/begin SPP_Layer/Flatten_3/Slice_1/size*
Index0*
T0*
_output_shapes
:
c
SPP_Layer/Flatten_3/ConstConst*
valueB: *
dtype0*
_output_shapes
:

SPP_Layer/Flatten_3/ProdProdSPP_Layer/Flatten_3/Slice_1SPP_Layer/Flatten_3/Const*
T0*
_output_shapes
: *
	keep_dims( *

Tidx0
d
"SPP_Layer/Flatten_3/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 

SPP_Layer/Flatten_3/ExpandDims
ExpandDimsSPP_Layer/Flatten_3/Prod"SPP_Layer/Flatten_3/ExpandDims/dim*
_output_shapes
:*

Tdim0*
T0
a
SPP_Layer/Flatten_3/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ź
SPP_Layer/Flatten_3/concatConcatV2SPP_Layer/Flatten_3/SliceSPP_Layer/Flatten_3/ExpandDimsSPP_Layer/Flatten_3/concat/axis*

Tidx0*
T0*
N*
_output_shapes
:

SPP_Layer/Flatten_3/ReshapeReshapeSPP_Layer/MaxPool_3SPP_Layer/Flatten_3/concat*'
_output_shapes
:˙˙˙˙˙˙˙˙˙*
T0*
Tshape0
W
SPP_Layer/concat/axisConst*
value	B :*
dtype0*
_output_shapes
: 
í
SPP_Layer/concatConcatV2SPP_Layer/Flatten/ReshapeSPP_Layer/Flatten_1/ReshapeSPP_Layer/Flatten_2/ReshapeSPP_Layer/Flatten_3/ReshapeSPP_Layer/concat/axis*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ *

Tidx0*
T0*
N
l
concat_values/Reshape/shapeConst*
valueB"˙˙˙˙   *
dtype0*
_output_shapes
:

concat_values/ReshapeReshapePlaceholder_2concat_values/Reshape/shape*
T0*
Tshape0*'
_output_shapes
:˙˙˙˙˙˙˙˙˙
n
concat_values/Reshape_1/shapeConst*
valueB"˙˙˙˙   *
dtype0*
_output_shapes
:

concat_values/Reshape_1ReshapePlaceholder_1concat_values/Reshape_1/shape*
T0*
Tshape0*'
_output_shapes
:˙˙˙˙˙˙˙˙˙
n
concat_values/Reshape_2/shapeConst*
valueB"˙˙˙˙   *
dtype0*
_output_shapes
:

concat_values/Reshape_2ReshapePlaceholder_3concat_values/Reshape_2/shape*'
_output_shapes
:˙˙˙˙˙˙˙˙˙*
T0*
Tshape0
[
concat_values/concat/axisConst*
value	B :*
dtype0*
_output_shapes
: 
Ţ
concat_values/concatConcatV2concat_values/Reshape_1concat_values/Reshapeconcat_values/Reshape_2SPP_Layer/concatconcat_values/concat/axis*
T0*
N*(
_output_shapes
:˙˙˙˙˙˙˙˙˙Ł*

Tidx0
c
conv1/weights_0/tagConst* 
valueB Bconv1/weights_0*
dtype0*
_output_shapes
: 
m
conv1/weights_0HistogramSummaryconv1/weights_0/tagconv1/weights/read*
T0*
_output_shapes
: 
q
conv1/BatchNorm/beta_0/tagConst*'
valueB Bconv1/BatchNorm/beta_0*
dtype0*
_output_shapes
: 

conv1/BatchNorm/beta_0HistogramSummaryconv1/BatchNorm/beta_0/tagconv1/BatchNorm/beta/read*
T0*
_output_shapes
: 

!conv1/BatchNorm/moving_mean_0/tagConst*
dtype0*
_output_shapes
: *.
value%B# Bconv1/BatchNorm/moving_mean_0

conv1/BatchNorm/moving_mean_0HistogramSummary!conv1/BatchNorm/moving_mean_0/tag conv1/BatchNorm/moving_mean/read*
T0*
_output_shapes
: 

%conv1/BatchNorm/moving_variance_0/tagConst*2
value)B' B!conv1/BatchNorm/moving_variance_0*
dtype0*
_output_shapes
: 
Ł
!conv1/BatchNorm/moving_variance_0HistogramSummary%conv1/BatchNorm/moving_variance_0/tag$conv1/BatchNorm/moving_variance/read*
T0*
_output_shapes
: 
c
conv2/weights_0/tagConst* 
valueB Bconv2/weights_0*
dtype0*
_output_shapes
: 
m
conv2/weights_0HistogramSummaryconv2/weights_0/tagconv2/weights/read*
T0*
_output_shapes
: 
q
conv2/BatchNorm/beta_0/tagConst*'
valueB Bconv2/BatchNorm/beta_0*
dtype0*
_output_shapes
: 

conv2/BatchNorm/beta_0HistogramSummaryconv2/BatchNorm/beta_0/tagconv2/BatchNorm/beta/read*
T0*
_output_shapes
: 

!conv2/BatchNorm/moving_mean_0/tagConst*.
value%B# Bconv2/BatchNorm/moving_mean_0*
dtype0*
_output_shapes
: 

conv2/BatchNorm/moving_mean_0HistogramSummary!conv2/BatchNorm/moving_mean_0/tag conv2/BatchNorm/moving_mean/read*
_output_shapes
: *
T0

%conv2/BatchNorm/moving_variance_0/tagConst*
_output_shapes
: *2
value)B' B!conv2/BatchNorm/moving_variance_0*
dtype0
Ł
!conv2/BatchNorm/moving_variance_0HistogramSummary%conv2/BatchNorm/moving_variance_0/tag$conv2/BatchNorm/moving_variance/read*
T0*
_output_shapes
: 
S
feature/tagConst*
_output_shapes
: *
valueB Bfeature*
dtype0
_
featureHistogramSummaryfeature/tagconcat_values/concat*
T0*
_output_shapes
: 

.fc1/weights/Initializer/truncated_normal/shapeConst*
_output_shapes
:*
_class
loc:@fc1/weights*
valueB"#     *
dtype0

-fc1/weights/Initializer/truncated_normal/meanConst*
_class
loc:@fc1/weights*
valueB
 *    *
dtype0*
_output_shapes
: 

/fc1/weights/Initializer/truncated_normal/stddevConst*
_class
loc:@fc1/weights*
valueB
 *
×#<*
dtype0*
_output_shapes
: 
ě
8fc1/weights/Initializer/truncated_normal/TruncatedNormalTruncatedNormal.fc1/weights/Initializer/truncated_normal/shape*
T0*
_class
loc:@fc1/weights*
seed2 *
dtype0* 
_output_shapes
:
Ł*

seed 
é
,fc1/weights/Initializer/truncated_normal/mulMul8fc1/weights/Initializer/truncated_normal/TruncatedNormal/fc1/weights/Initializer/truncated_normal/stddev*
_class
loc:@fc1/weights* 
_output_shapes
:
Ł*
T0
×
(fc1/weights/Initializer/truncated_normalAdd,fc1/weights/Initializer/truncated_normal/mul-fc1/weights/Initializer/truncated_normal/mean*
_class
loc:@fc1/weights* 
_output_shapes
:
Ł*
T0
Ł
fc1/weights
VariableV2*
shared_name *
_class
loc:@fc1/weights*
	container *
shape:
Ł*
dtype0* 
_output_shapes
:
Ł
Ç
fc1/weights/AssignAssignfc1/weights(fc1/weights/Initializer/truncated_normal*
_class
loc:@fc1/weights*
validate_shape(* 
_output_shapes
:
Ł*
use_locking(*
T0
t
fc1/weights/readIdentityfc1/weights*
T0*
_class
loc:@fc1/weights* 
_output_shapes
:
Ł

fc1/biases/Initializer/zerosConst*
_class
loc:@fc1/biases*
valueB*    *
dtype0*
_output_shapes	
:


fc1/biases
VariableV2*
shape:*
dtype0*
_output_shapes	
:*
shared_name *
_class
loc:@fc1/biases*
	container 
ł
fc1/biases/AssignAssign
fc1/biasesfc1/biases/Initializer/zeros*
_class
loc:@fc1/biases*
validate_shape(*
_output_shapes	
:*
use_locking(*
T0
l
fc1/biases/readIdentity
fc1/biases*
T0*
_class
loc:@fc1/biases*
_output_shapes	
:


fc1/MatMulMatMulconcat_values/concatfc1/weights/read*(
_output_shapes
:˙˙˙˙˙˙˙˙˙*
transpose_a( *
transpose_b( *
T0
}
fc1/BiasAddBiasAdd
fc1/MatMulfc1/biases/read*
T0*
data_formatNHWC*(
_output_shapes
:˙˙˙˙˙˙˙˙˙
P
fc1/ReluRelufc1/BiasAdd*
T0*(
_output_shapes
:˙˙˙˙˙˙˙˙˙
_
dropout1/dropout/keep_probConst*
dtype0*
_output_shapes
: *
valueB
 *  ?

.fc2/weights/Initializer/truncated_normal/shapeConst*
_class
loc:@fc2/weights*
valueB"      *
dtype0*
_output_shapes
:

-fc2/weights/Initializer/truncated_normal/meanConst*
_class
loc:@fc2/weights*
valueB
 *    *
dtype0*
_output_shapes
: 

/fc2/weights/Initializer/truncated_normal/stddevConst*
dtype0*
_output_shapes
: *
_class
loc:@fc2/weights*
valueB
 *
×#<
ě
8fc2/weights/Initializer/truncated_normal/TruncatedNormalTruncatedNormal.fc2/weights/Initializer/truncated_normal/shape*
_class
loc:@fc2/weights*
seed2 *
dtype0* 
_output_shapes
:
*

seed *
T0
é
,fc2/weights/Initializer/truncated_normal/mulMul8fc2/weights/Initializer/truncated_normal/TruncatedNormal/fc2/weights/Initializer/truncated_normal/stddev*
_class
loc:@fc2/weights* 
_output_shapes
:
*
T0
×
(fc2/weights/Initializer/truncated_normalAdd,fc2/weights/Initializer/truncated_normal/mul-fc2/weights/Initializer/truncated_normal/mean*
T0*
_class
loc:@fc2/weights* 
_output_shapes
:

Ł
fc2/weights
VariableV2*
shared_name *
_class
loc:@fc2/weights*
	container *
shape:
*
dtype0* 
_output_shapes
:

Ç
fc2/weights/AssignAssignfc2/weights(fc2/weights/Initializer/truncated_normal*
T0*
_class
loc:@fc2/weights*
validate_shape(* 
_output_shapes
:
*
use_locking(
t
fc2/weights/readIdentityfc2/weights*
T0*
_class
loc:@fc2/weights* 
_output_shapes
:


fc2/biases/Initializer/zerosConst*
_class
loc:@fc2/biases*
valueB*    *
dtype0*
_output_shapes	
:


fc2/biases
VariableV2*
_class
loc:@fc2/biases*
	container *
shape:*
dtype0*
_output_shapes	
:*
shared_name 
ł
fc2/biases/AssignAssign
fc2/biasesfc2/biases/Initializer/zeros*
validate_shape(*
_output_shapes	
:*
use_locking(*
T0*
_class
loc:@fc2/biases
l
fc2/biases/readIdentity
fc2/biases*
_output_shapes	
:*
T0*
_class
loc:@fc2/biases


fc2/MatMulMatMulfc1/Relufc2/weights/read*(
_output_shapes
:˙˙˙˙˙˙˙˙˙*
transpose_a( *
transpose_b( *
T0
}
fc2/BiasAddBiasAdd
fc2/MatMulfc2/biases/read*
T0*
data_formatNHWC*(
_output_shapes
:˙˙˙˙˙˙˙˙˙
P
fc2/ReluRelufc2/BiasAdd*
T0*(
_output_shapes
:˙˙˙˙˙˙˙˙˙
_
dropout2/dropout/keep_probConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
Ľ
1output/weights/Initializer/truncated_normal/shapeConst*!
_class
loc:@output/weights*
valueB"   	   *
dtype0*
_output_shapes
:

0output/weights/Initializer/truncated_normal/meanConst*!
_class
loc:@output/weights*
valueB
 *    *
dtype0*
_output_shapes
: 

2output/weights/Initializer/truncated_normal/stddevConst*!
_class
loc:@output/weights*
valueB
 *
×#<*
dtype0*
_output_shapes
: 
ô
;output/weights/Initializer/truncated_normal/TruncatedNormalTruncatedNormal1output/weights/Initializer/truncated_normal/shape*
seed2 *
dtype0*
_output_shapes
:		*

seed *
T0*!
_class
loc:@output/weights
ô
/output/weights/Initializer/truncated_normal/mulMul;output/weights/Initializer/truncated_normal/TruncatedNormal2output/weights/Initializer/truncated_normal/stddev*!
_class
loc:@output/weights*
_output_shapes
:		*
T0
â
+output/weights/Initializer/truncated_normalAdd/output/weights/Initializer/truncated_normal/mul0output/weights/Initializer/truncated_normal/mean*
_output_shapes
:		*
T0*!
_class
loc:@output/weights
§
output/weights
VariableV2*
shared_name *!
_class
loc:@output/weights*
	container *
shape:		*
dtype0*
_output_shapes
:		
Ň
output/weights/AssignAssignoutput/weights+output/weights/Initializer/truncated_normal*
validate_shape(*
_output_shapes
:		*
use_locking(*
T0*!
_class
loc:@output/weights
|
output/weights/readIdentityoutput/weights*
T0*!
_class
loc:@output/weights*
_output_shapes
:		

output/biases/Initializer/zerosConst*
dtype0*
_output_shapes
:	* 
_class
loc:@output/biases*
valueB	*    

output/biases
VariableV2*
shape:	*
dtype0*
_output_shapes
:	*
shared_name * 
_class
loc:@output/biases*
	container 
ž
output/biases/AssignAssignoutput/biasesoutput/biases/Initializer/zeros* 
_class
loc:@output/biases*
validate_shape(*
_output_shapes
:	*
use_locking(*
T0
t
output/biases/readIdentityoutput/biases*
T0* 
_class
loc:@output/biases*
_output_shapes
:	

output/MatMulMatMulfc2/Reluoutput/weights/read*
T0*'
_output_shapes
:˙˙˙˙˙˙˙˙˙	*
transpose_a( *
transpose_b( 

output/BiasAddBiasAddoutput/MatMuloutput/biases/read*
T0*
data_formatNHWC*'
_output_shapes
:˙˙˙˙˙˙˙˙˙	
W

accuraciesSoftmaxoutput/BiasAdd*
T0*'
_output_shapes
:˙˙˙˙˙˙˙˙˙	
L

predicts/kConst*
value	B :*
dtype0*
_output_shapes
: 
}
predictsTopKV2
accuracies
predicts/k*:
_output_shapes(
&:˙˙˙˙˙˙˙˙˙:˙˙˙˙˙˙˙˙˙*
sorted(*
T0
P

save/ConstConst*
valueB Bmodel*
dtype0*
_output_shapes
: 
ů
save/SaveV2/tensor_namesConst*Ź
value˘BBconv1/BatchNorm/betaBconv1/BatchNorm/moving_meanBconv1/BatchNorm/moving_varianceBconv1/weightsBconv2/BatchNorm/betaBconv2/BatchNorm/moving_meanBconv2/BatchNorm/moving_varianceBconv2/weightsB
fc1/biasesBfc1/weightsB
fc2/biasesBfc2/weightsBoutput/biasesBoutput/weights*
dtype0*
_output_shapes
:

save/SaveV2/shape_and_slicesConst*/
value&B$B B B B B B B B B B B B B B *
dtype0*
_output_shapes
:

save/SaveV2SaveV2
save/Constsave/SaveV2/tensor_namessave/SaveV2/shape_and_slicesconv1/BatchNorm/betaconv1/BatchNorm/moving_meanconv1/BatchNorm/moving_varianceconv1/weightsconv2/BatchNorm/betaconv2/BatchNorm/moving_meanconv2/BatchNorm/moving_varianceconv2/weights
fc1/biasesfc1/weights
fc2/biasesfc2/weightsoutput/biasesoutput/weights*
dtypes
2
}
save/control_dependencyIdentity
save/Const^save/SaveV2*
T0*
_class
loc:@save/Const*
_output_shapes
: 
x
save/RestoreV2/tensor_namesConst*)
value BBconv1/BatchNorm/beta*
dtype0*
_output_shapes
:
h
save/RestoreV2/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save/RestoreV2	RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices*
dtypes
2*
_output_shapes
:
˛
save/AssignAssignconv1/BatchNorm/betasave/RestoreV2*
use_locking(*
T0*'
_class
loc:@conv1/BatchNorm/beta*
validate_shape(*
_output_shapes
:

save/RestoreV2_1/tensor_namesConst*0
value'B%Bconv1/BatchNorm/moving_mean*
dtype0*
_output_shapes
:
j
!save/RestoreV2_1/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save/RestoreV2_1	RestoreV2
save/Constsave/RestoreV2_1/tensor_names!save/RestoreV2_1/shape_and_slices*
_output_shapes
:*
dtypes
2
Ä
save/Assign_1Assignconv1/BatchNorm/moving_meansave/RestoreV2_1*.
_class$
" loc:@conv1/BatchNorm/moving_mean*
validate_shape(*
_output_shapes
:*
use_locking(*
T0

save/RestoreV2_2/tensor_namesConst*4
value+B)Bconv1/BatchNorm/moving_variance*
dtype0*
_output_shapes
:
j
!save/RestoreV2_2/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save/RestoreV2_2	RestoreV2
save/Constsave/RestoreV2_2/tensor_names!save/RestoreV2_2/shape_and_slices*
dtypes
2*
_output_shapes
:
Ě
save/Assign_2Assignconv1/BatchNorm/moving_variancesave/RestoreV2_2*
use_locking(*
T0*2
_class(
&$loc:@conv1/BatchNorm/moving_variance*
validate_shape(*
_output_shapes
:
s
save/RestoreV2_3/tensor_namesConst*"
valueBBconv1/weights*
dtype0*
_output_shapes
:
j
!save/RestoreV2_3/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save/RestoreV2_3	RestoreV2
save/Constsave/RestoreV2_3/tensor_names!save/RestoreV2_3/shape_and_slices*
dtypes
2*
_output_shapes
:
´
save/Assign_3Assignconv1/weightssave/RestoreV2_3*
use_locking(*
T0* 
_class
loc:@conv1/weights*
validate_shape(*&
_output_shapes
:
z
save/RestoreV2_4/tensor_namesConst*)
value BBconv2/BatchNorm/beta*
dtype0*
_output_shapes
:
j
!save/RestoreV2_4/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save/RestoreV2_4	RestoreV2
save/Constsave/RestoreV2_4/tensor_names!save/RestoreV2_4/shape_and_slices*
_output_shapes
:*
dtypes
2
ś
save/Assign_4Assignconv2/BatchNorm/betasave/RestoreV2_4*
validate_shape(*
_output_shapes
:*
use_locking(*
T0*'
_class
loc:@conv2/BatchNorm/beta

save/RestoreV2_5/tensor_namesConst*
dtype0*
_output_shapes
:*0
value'B%Bconv2/BatchNorm/moving_mean
j
!save/RestoreV2_5/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save/RestoreV2_5	RestoreV2
save/Constsave/RestoreV2_5/tensor_names!save/RestoreV2_5/shape_and_slices*
_output_shapes
:*
dtypes
2
Ä
save/Assign_5Assignconv2/BatchNorm/moving_meansave/RestoreV2_5*
use_locking(*
T0*.
_class$
" loc:@conv2/BatchNorm/moving_mean*
validate_shape(*
_output_shapes
:

save/RestoreV2_6/tensor_namesConst*
dtype0*
_output_shapes
:*4
value+B)Bconv2/BatchNorm/moving_variance
j
!save/RestoreV2_6/shape_and_slicesConst*
_output_shapes
:*
valueB
B *
dtype0

save/RestoreV2_6	RestoreV2
save/Constsave/RestoreV2_6/tensor_names!save/RestoreV2_6/shape_and_slices*
_output_shapes
:*
dtypes
2
Ě
save/Assign_6Assignconv2/BatchNorm/moving_variancesave/RestoreV2_6*2
_class(
&$loc:@conv2/BatchNorm/moving_variance*
validate_shape(*
_output_shapes
:*
use_locking(*
T0
s
save/RestoreV2_7/tensor_namesConst*"
valueBBconv2/weights*
dtype0*
_output_shapes
:
j
!save/RestoreV2_7/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save/RestoreV2_7	RestoreV2
save/Constsave/RestoreV2_7/tensor_names!save/RestoreV2_7/shape_and_slices*
_output_shapes
:*
dtypes
2
´
save/Assign_7Assignconv2/weightssave/RestoreV2_7*
T0* 
_class
loc:@conv2/weights*
validate_shape(*&
_output_shapes
:*
use_locking(
p
save/RestoreV2_8/tensor_namesConst*
valueBB
fc1/biases*
dtype0*
_output_shapes
:
j
!save/RestoreV2_8/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save/RestoreV2_8	RestoreV2
save/Constsave/RestoreV2_8/tensor_names!save/RestoreV2_8/shape_and_slices*
_output_shapes
:*
dtypes
2
Ł
save/Assign_8Assign
fc1/biasessave/RestoreV2_8*
use_locking(*
T0*
_class
loc:@fc1/biases*
validate_shape(*
_output_shapes	
:
q
save/RestoreV2_9/tensor_namesConst* 
valueBBfc1/weights*
dtype0*
_output_shapes
:
j
!save/RestoreV2_9/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save/RestoreV2_9	RestoreV2
save/Constsave/RestoreV2_9/tensor_names!save/RestoreV2_9/shape_and_slices*
_output_shapes
:*
dtypes
2
Ş
save/Assign_9Assignfc1/weightssave/RestoreV2_9* 
_output_shapes
:
Ł*
use_locking(*
T0*
_class
loc:@fc1/weights*
validate_shape(
q
save/RestoreV2_10/tensor_namesConst*
valueBB
fc2/biases*
dtype0*
_output_shapes
:
k
"save/RestoreV2_10/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save/RestoreV2_10	RestoreV2
save/Constsave/RestoreV2_10/tensor_names"save/RestoreV2_10/shape_and_slices*
_output_shapes
:*
dtypes
2
Ľ
save/Assign_10Assign
fc2/biasessave/RestoreV2_10*
use_locking(*
T0*
_class
loc:@fc2/biases*
validate_shape(*
_output_shapes	
:
r
save/RestoreV2_11/tensor_namesConst* 
valueBBfc2/weights*
dtype0*
_output_shapes
:
k
"save/RestoreV2_11/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save/RestoreV2_11	RestoreV2
save/Constsave/RestoreV2_11/tensor_names"save/RestoreV2_11/shape_and_slices*
_output_shapes
:*
dtypes
2
Ź
save/Assign_11Assignfc2/weightssave/RestoreV2_11*
use_locking(*
T0*
_class
loc:@fc2/weights*
validate_shape(* 
_output_shapes
:

t
save/RestoreV2_12/tensor_namesConst*"
valueBBoutput/biases*
dtype0*
_output_shapes
:
k
"save/RestoreV2_12/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save/RestoreV2_12	RestoreV2
save/Constsave/RestoreV2_12/tensor_names"save/RestoreV2_12/shape_and_slices*
_output_shapes
:*
dtypes
2
Ş
save/Assign_12Assignoutput/biasessave/RestoreV2_12*
_output_shapes
:	*
use_locking(*
T0* 
_class
loc:@output/biases*
validate_shape(
u
save/RestoreV2_13/tensor_namesConst*#
valueBBoutput/weights*
dtype0*
_output_shapes
:
k
"save/RestoreV2_13/shape_and_slicesConst*
dtype0*
_output_shapes
:*
valueB
B 

save/RestoreV2_13	RestoreV2
save/Constsave/RestoreV2_13/tensor_names"save/RestoreV2_13/shape_and_slices*
dtypes
2*
_output_shapes
:
ą
save/Assign_13Assignoutput/weightssave/RestoreV2_13*
use_locking(*
T0*!
_class
loc:@output/weights*
validate_shape(*
_output_shapes
:		
ú
save/restore_allNoOp^save/Assign^save/Assign_1^save/Assign_2^save/Assign_3^save/Assign_4^save/Assign_5^save/Assign_6^save/Assign_7^save/Assign_8^save/Assign_9^save/Assign_10^save/Assign_11^save/Assign_12^save/Assign_13
˘
Merge/MergeSummaryMergeSummaryconv1/weights_0conv1/BatchNorm/beta_0conv1/BatchNorm/moving_mean_0!conv1/BatchNorm/moving_variance_0conv2/weights_0conv2/BatchNorm/beta_0conv2/BatchNorm/moving_mean_0!conv2/BatchNorm/moving_variance_0feature*
N	*
_output_shapes
: 
R
save_1/ConstConst*
valueB Bmodel*
dtype0*
_output_shapes
: 

save_1/StringJoin/inputs_1Const*<
value3B1 B+_temp_16924e47c378486b911700ba298989d2/part*
dtype0*
_output_shapes
: 
{
save_1/StringJoin
StringJoinsave_1/Constsave_1/StringJoin/inputs_1*
N*
_output_shapes
: *
	separator 
S
save_1/num_shardsConst*
value	B :*
dtype0*
_output_shapes
: 
^
save_1/ShardedFilename/shardConst*
value	B : *
dtype0*
_output_shapes
: 

save_1/ShardedFilenameShardedFilenamesave_1/StringJoinsave_1/ShardedFilename/shardsave_1/num_shards*
_output_shapes
: 
ű
save_1/SaveV2/tensor_namesConst*
dtype0*
_output_shapes
:*Ź
value˘BBconv1/BatchNorm/betaBconv1/BatchNorm/moving_meanBconv1/BatchNorm/moving_varianceBconv1/weightsBconv2/BatchNorm/betaBconv2/BatchNorm/moving_meanBconv2/BatchNorm/moving_varianceBconv2/weightsB
fc1/biasesBfc1/weightsB
fc2/biasesBfc2/weightsBoutput/biasesBoutput/weights

save_1/SaveV2/shape_and_slicesConst*/
value&B$B B B B B B B B B B B B B B *
dtype0*
_output_shapes
:
 
save_1/SaveV2SaveV2save_1/ShardedFilenamesave_1/SaveV2/tensor_namessave_1/SaveV2/shape_and_slicesconv1/BatchNorm/betaconv1/BatchNorm/moving_meanconv1/BatchNorm/moving_varianceconv1/weightsconv2/BatchNorm/betaconv2/BatchNorm/moving_meanconv2/BatchNorm/moving_varianceconv2/weights
fc1/biasesfc1/weights
fc2/biasesfc2/weightsoutput/biasesoutput/weights*
dtypes
2

save_1/control_dependencyIdentitysave_1/ShardedFilename^save_1/SaveV2*
_output_shapes
: *
T0*)
_class
loc:@save_1/ShardedFilename
Ł
-save_1/MergeV2Checkpoints/checkpoint_prefixesPacksave_1/ShardedFilename^save_1/control_dependency*
T0*

axis *
N*
_output_shapes
:

save_1/MergeV2CheckpointsMergeV2Checkpoints-save_1/MergeV2Checkpoints/checkpoint_prefixessave_1/Const*
delete_old_dirs(

save_1/IdentityIdentitysave_1/Const^save_1/control_dependency^save_1/MergeV2Checkpoints*
T0*
_output_shapes
: 
z
save_1/RestoreV2/tensor_namesConst*)
value BBconv1/BatchNorm/beta*
dtype0*
_output_shapes
:
j
!save_1/RestoreV2/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save_1/RestoreV2	RestoreV2save_1/Constsave_1/RestoreV2/tensor_names!save_1/RestoreV2/shape_and_slices*
_output_shapes
:*
dtypes
2
ś
save_1/AssignAssignconv1/BatchNorm/betasave_1/RestoreV2*
validate_shape(*
_output_shapes
:*
use_locking(*
T0*'
_class
loc:@conv1/BatchNorm/beta

save_1/RestoreV2_1/tensor_namesConst*0
value'B%Bconv1/BatchNorm/moving_mean*
dtype0*
_output_shapes
:
l
#save_1/RestoreV2_1/shape_and_slicesConst*
dtype0*
_output_shapes
:*
valueB
B 

save_1/RestoreV2_1	RestoreV2save_1/Constsave_1/RestoreV2_1/tensor_names#save_1/RestoreV2_1/shape_and_slices*
_output_shapes
:*
dtypes
2
Č
save_1/Assign_1Assignconv1/BatchNorm/moving_meansave_1/RestoreV2_1*
validate_shape(*
_output_shapes
:*
use_locking(*
T0*.
_class$
" loc:@conv1/BatchNorm/moving_mean

save_1/RestoreV2_2/tensor_namesConst*4
value+B)Bconv1/BatchNorm/moving_variance*
dtype0*
_output_shapes
:
l
#save_1/RestoreV2_2/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save_1/RestoreV2_2	RestoreV2save_1/Constsave_1/RestoreV2_2/tensor_names#save_1/RestoreV2_2/shape_and_slices*
dtypes
2*
_output_shapes
:
Đ
save_1/Assign_2Assignconv1/BatchNorm/moving_variancesave_1/RestoreV2_2*2
_class(
&$loc:@conv1/BatchNorm/moving_variance*
validate_shape(*
_output_shapes
:*
use_locking(*
T0
u
save_1/RestoreV2_3/tensor_namesConst*"
valueBBconv1/weights*
dtype0*
_output_shapes
:
l
#save_1/RestoreV2_3/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save_1/RestoreV2_3	RestoreV2save_1/Constsave_1/RestoreV2_3/tensor_names#save_1/RestoreV2_3/shape_and_slices*
_output_shapes
:*
dtypes
2
¸
save_1/Assign_3Assignconv1/weightssave_1/RestoreV2_3*&
_output_shapes
:*
use_locking(*
T0* 
_class
loc:@conv1/weights*
validate_shape(
|
save_1/RestoreV2_4/tensor_namesConst*)
value BBconv2/BatchNorm/beta*
dtype0*
_output_shapes
:
l
#save_1/RestoreV2_4/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save_1/RestoreV2_4	RestoreV2save_1/Constsave_1/RestoreV2_4/tensor_names#save_1/RestoreV2_4/shape_and_slices*
_output_shapes
:*
dtypes
2
ş
save_1/Assign_4Assignconv2/BatchNorm/betasave_1/RestoreV2_4*
use_locking(*
T0*'
_class
loc:@conv2/BatchNorm/beta*
validate_shape(*
_output_shapes
:

save_1/RestoreV2_5/tensor_namesConst*0
value'B%Bconv2/BatchNorm/moving_mean*
dtype0*
_output_shapes
:
l
#save_1/RestoreV2_5/shape_and_slicesConst*
dtype0*
_output_shapes
:*
valueB
B 

save_1/RestoreV2_5	RestoreV2save_1/Constsave_1/RestoreV2_5/tensor_names#save_1/RestoreV2_5/shape_and_slices*
_output_shapes
:*
dtypes
2
Č
save_1/Assign_5Assignconv2/BatchNorm/moving_meansave_1/RestoreV2_5*
use_locking(*
T0*.
_class$
" loc:@conv2/BatchNorm/moving_mean*
validate_shape(*
_output_shapes
:

save_1/RestoreV2_6/tensor_namesConst*
_output_shapes
:*4
value+B)Bconv2/BatchNorm/moving_variance*
dtype0
l
#save_1/RestoreV2_6/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save_1/RestoreV2_6	RestoreV2save_1/Constsave_1/RestoreV2_6/tensor_names#save_1/RestoreV2_6/shape_and_slices*
_output_shapes
:*
dtypes
2
Đ
save_1/Assign_6Assignconv2/BatchNorm/moving_variancesave_1/RestoreV2_6*2
_class(
&$loc:@conv2/BatchNorm/moving_variance*
validate_shape(*
_output_shapes
:*
use_locking(*
T0
u
save_1/RestoreV2_7/tensor_namesConst*"
valueBBconv2/weights*
dtype0*
_output_shapes
:
l
#save_1/RestoreV2_7/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save_1/RestoreV2_7	RestoreV2save_1/Constsave_1/RestoreV2_7/tensor_names#save_1/RestoreV2_7/shape_and_slices*
dtypes
2*
_output_shapes
:
¸
save_1/Assign_7Assignconv2/weightssave_1/RestoreV2_7*
use_locking(*
T0* 
_class
loc:@conv2/weights*
validate_shape(*&
_output_shapes
:
r
save_1/RestoreV2_8/tensor_namesConst*
_output_shapes
:*
valueBB
fc1/biases*
dtype0
l
#save_1/RestoreV2_8/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save_1/RestoreV2_8	RestoreV2save_1/Constsave_1/RestoreV2_8/tensor_names#save_1/RestoreV2_8/shape_and_slices*
_output_shapes
:*
dtypes
2
§
save_1/Assign_8Assign
fc1/biasessave_1/RestoreV2_8*
use_locking(*
T0*
_class
loc:@fc1/biases*
validate_shape(*
_output_shapes	
:
s
save_1/RestoreV2_9/tensor_namesConst* 
valueBBfc1/weights*
dtype0*
_output_shapes
:
l
#save_1/RestoreV2_9/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save_1/RestoreV2_9	RestoreV2save_1/Constsave_1/RestoreV2_9/tensor_names#save_1/RestoreV2_9/shape_and_slices*
dtypes
2*
_output_shapes
:
Ž
save_1/Assign_9Assignfc1/weightssave_1/RestoreV2_9*
use_locking(*
T0*
_class
loc:@fc1/weights*
validate_shape(* 
_output_shapes
:
Ł
s
 save_1/RestoreV2_10/tensor_namesConst*
valueBB
fc2/biases*
dtype0*
_output_shapes
:
m
$save_1/RestoreV2_10/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
Ą
save_1/RestoreV2_10	RestoreV2save_1/Const save_1/RestoreV2_10/tensor_names$save_1/RestoreV2_10/shape_and_slices*
_output_shapes
:*
dtypes
2
Š
save_1/Assign_10Assign
fc2/biasessave_1/RestoreV2_10*
use_locking(*
T0*
_class
loc:@fc2/biases*
validate_shape(*
_output_shapes	
:
t
 save_1/RestoreV2_11/tensor_namesConst* 
valueBBfc2/weights*
dtype0*
_output_shapes
:
m
$save_1/RestoreV2_11/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
Ą
save_1/RestoreV2_11	RestoreV2save_1/Const save_1/RestoreV2_11/tensor_names$save_1/RestoreV2_11/shape_and_slices*
_output_shapes
:*
dtypes
2
°
save_1/Assign_11Assignfc2/weightssave_1/RestoreV2_11*
_class
loc:@fc2/weights*
validate_shape(* 
_output_shapes
:
*
use_locking(*
T0
v
 save_1/RestoreV2_12/tensor_namesConst*"
valueBBoutput/biases*
dtype0*
_output_shapes
:
m
$save_1/RestoreV2_12/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
Ą
save_1/RestoreV2_12	RestoreV2save_1/Const save_1/RestoreV2_12/tensor_names$save_1/RestoreV2_12/shape_and_slices*
_output_shapes
:*
dtypes
2
Ž
save_1/Assign_12Assignoutput/biasessave_1/RestoreV2_12*
_output_shapes
:	*
use_locking(*
T0* 
_class
loc:@output/biases*
validate_shape(
w
 save_1/RestoreV2_13/tensor_namesConst*#
valueBBoutput/weights*
dtype0*
_output_shapes
:
m
$save_1/RestoreV2_13/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
Ą
save_1/RestoreV2_13	RestoreV2save_1/Const save_1/RestoreV2_13/tensor_names$save_1/RestoreV2_13/shape_and_slices*
dtypes
2*
_output_shapes
:
ľ
save_1/Assign_13Assignoutput/weightssave_1/RestoreV2_13*
use_locking(*
T0*!
_class
loc:@output/weights*
validate_shape(*
_output_shapes
:		

save_1/restore_shardNoOp^save_1/Assign^save_1/Assign_1^save_1/Assign_2^save_1/Assign_3^save_1/Assign_4^save_1/Assign_5^save_1/Assign_6^save_1/Assign_7^save_1/Assign_8^save_1/Assign_9^save_1/Assign_10^save_1/Assign_11^save_1/Assign_12^save_1/Assign_13
1
save_1/restore_allNoOp^save_1/restore_shard"B
save_1/Const:0save_1/Identity:0save_1/restore_all (5 @F8"Ň
	variablesÄÁ
=
conv1/weights:0conv1/weights/Assignconv1/weights/read:0
R
conv1/BatchNorm/beta:0conv1/BatchNorm/beta/Assignconv1/BatchNorm/beta/read:0
g
conv1/BatchNorm/moving_mean:0"conv1/BatchNorm/moving_mean/Assign"conv1/BatchNorm/moving_mean/read:0
s
!conv1/BatchNorm/moving_variance:0&conv1/BatchNorm/moving_variance/Assign&conv1/BatchNorm/moving_variance/read:0
=
conv2/weights:0conv2/weights/Assignconv2/weights/read:0
R
conv2/BatchNorm/beta:0conv2/BatchNorm/beta/Assignconv2/BatchNorm/beta/read:0
g
conv2/BatchNorm/moving_mean:0"conv2/BatchNorm/moving_mean/Assign"conv2/BatchNorm/moving_mean/read:0
s
!conv2/BatchNorm/moving_variance:0&conv2/BatchNorm/moving_variance/Assign&conv2/BatchNorm/moving_variance/read:0
7
fc1/weights:0fc1/weights/Assignfc1/weights/read:0
4
fc1/biases:0fc1/biases/Assignfc1/biases/read:0
7
fc2/weights:0fc2/weights/Assignfc2/weights/read:0
4
fc2/biases:0fc2/biases/Assignfc2/biases/read:0
@
output/weights:0output/weights/Assignoutput/weights/read:0
=
output/biases:0output/biases/Assignoutput/biases/read:0"Ř
model_variablesÄÁ
=
conv1/weights:0conv1/weights/Assignconv1/weights/read:0
R
conv1/BatchNorm/beta:0conv1/BatchNorm/beta/Assignconv1/BatchNorm/beta/read:0
g
conv1/BatchNorm/moving_mean:0"conv1/BatchNorm/moving_mean/Assign"conv1/BatchNorm/moving_mean/read:0
s
!conv1/BatchNorm/moving_variance:0&conv1/BatchNorm/moving_variance/Assign&conv1/BatchNorm/moving_variance/read:0
=
conv2/weights:0conv2/weights/Assignconv2/weights/read:0
R
conv2/BatchNorm/beta:0conv2/BatchNorm/beta/Assignconv2/BatchNorm/beta/read:0
g
conv2/BatchNorm/moving_mean:0"conv2/BatchNorm/moving_mean/Assign"conv2/BatchNorm/moving_mean/read:0
s
!conv2/BatchNorm/moving_variance:0&conv2/BatchNorm/moving_variance/Assign&conv2/BatchNorm/moving_variance/read:0
7
fc1/weights:0fc1/weights/Assignfc1/weights/read:0
4
fc1/biases:0fc1/biases/Assignfc1/biases/read:0
7
fc2/weights:0fc2/weights/Assignfc2/weights/read:0
4
fc2/biases:0fc2/biases/Assignfc2/biases/read:0
@
output/weights:0output/weights/Assignoutput/weights/read:0
=
output/biases:0output/biases/Assignoutput/biases/read:0"
	summariesô
ń
conv1/weights_0:0
conv1/BatchNorm/beta_0:0
conv1/BatchNorm/moving_mean_0:0
#conv1/BatchNorm/moving_variance_0:0
conv2/weights_0:0
conv2/BatchNorm/beta_0:0
conv2/BatchNorm/moving_mean_0:0
#conv2/BatchNorm/moving_variance_0:0
	feature:0" 
trainable_variables
=
conv1/weights:0conv1/weights/Assignconv1/weights/read:0
R
conv1/BatchNorm/beta:0conv1/BatchNorm/beta/Assignconv1/BatchNorm/beta/read:0
=
conv2/weights:0conv2/weights/Assignconv2/weights/read:0
R
conv2/BatchNorm/beta:0conv2/BatchNorm/beta/Assignconv2/BatchNorm/beta/read:0
7
fc1/weights:0fc1/weights/Assignfc1/weights/read:0
4
fc1/biases:0fc1/biases/Assignfc1/biases/read:0
7
fc2/weights:0fc2/weights/Assignfc2/weights/read:0
4
fc2/biases:0fc2/biases/Assignfc2/biases/read:0
@
output/weights:0output/weights/Assignoutput/weights/read:0
=
output/biases:0output/biases/Assignoutput/biases/read:0*ł
serving_default
"
lengths
Placeholder_1:0
!
widths
Placeholder_2:0
 
areas
Placeholder_3:0
6
images,
Placeholder:0˙˙˙˙˙˙˙˙˙H1

accuracies#
accuracies:0˙˙˙˙˙˙˙˙˙	-
predicts!

predicts:1˙˙˙˙˙˙˙˙˙tensorflow/serving/predict