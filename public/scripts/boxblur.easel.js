/*
* BoxBlurFilter
* Visit http://createjs.com/ for documentation, updates and examples.
*
* Copyright (c) 2010 gskinner.com, inc.
* 
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without
* restriction, including without limitation the rights to use,
* copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the
* Software is furnished to do so, subject to the following
* conditions:
* 
* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
* OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
* HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
* OTHER DEALINGS IN THE SOFTWARE.
*/

this.createjs=this.createjs||{};(function(){var e=function(e,t,n){this.initialize(e,t,n)};var t=e.prototype=new createjs.Filter;t.initialize=function(e,t,n){if(isNaN(e)||e<0)e=0;this.blurX=e|0;if(isNaN(t)||t<0)t=0;this.blurY=t|0;if(isNaN(n)||n<1)n=1;this.quality=n|0};t.blurX=0;t.blurY=0;t.quality=1;t.getBounds=function(){return new createjs.Rectangle(-this.blurX,-this.blurY,2*this.blurX,2*this.blurY)};t.applyFilter=function(e,t,n,r,i,s,o,u){s=s||e;if(o==null){o=t}if(u==null){u=n}try{var a=e.getImageData(t,n,r,i)}catch(f){return false}var l=this.blurX;if(isNaN(l)||l<0)return false;l|=0;var c=this.blurY;if(isNaN(c)||c<0)return false;c|=0;if(l==0&&c==0)return false;var h=this.quality;if(isNaN(h)||h<1)h=1;h|=0;if(h>3)h=3;if(h<1)h=1;var p=a.data;var d,v,m,g,t,n,y,b,w,E,S,x,T;var N=r-1;var C=i-1;var k=l+1;var L=l+k;var A=c+1;var O=c+A;var M=1/(L*O);var _=[];var D=[];var P=[];var H=[];var B=[];var j=[];while(h-->0){T=x=0;for(n=0;n<i;n++){d=p[T]*k;v=p[T+1]*k;m=p[T+2]*k;g=p[T+3]*k;for(y=1;y<=l;y++){b=T+((y>N?N:y)<<2);d+=p[b++];v+=p[b++];m+=p[b++];g+=p[b]}for(t=0;t<r;t++){_[x]=d;D[x]=v;P[x]=m;H[x]=g;if(n==0){B[t]=Math.min(t+k,N)<<2;j[t]=Math.max(t-l,0)<<2}w=T+B[t];E=T+j[t];d+=p[w++]-p[E++];v+=p[w++]-p[E++];m+=p[w++]-p[E++];g+=p[w]-p[E];x++}T+=r<<2}for(t=0;t<r;t++){S=t;d=_[S]*A;v=D[S]*A;m=P[S]*A;g=H[S]*A;for(y=1;y<=c;y++){S+=y>C?0:r;d+=_[S];v+=D[S];m+=P[S];g+=H[S]}x=t<<2;for(n=0;n<i;n++){p[x]=d*M+.5|0;p[x+1]=v*M+.5|0;p[x+2]=m*M+.5|0;p[x+3]=g*M+.5|0;if(t==0){B[n]=Math.min(n+A,C)*r;j[n]=Math.max(n-c,0)*r}w=t+B[n];E=t+j[n];d+=_[w]-_[E];v+=D[w]-D[E];m+=P[w]-P[E];g+=H[w]-H[E];x+=r<<2}}}s.putImageData(a,o,u);return true};t.clone=function(){return new e(this.blurX,this.blurY,this.quality)};t.toString=function(){return"[BoxBlurFilter]"};createjs.BoxBlurFilter=e})()