// dy/dx = f(x,y) の解析，オイラー法

#include <bits/stdc++.h>
using namespace std;
typedef long double ld;
ld dy_dx(ld x,ld y){
	return 2.0*x;
}
int main(){
	ld x,y,dx;
	x = 5.0;	 // xの初期値の設定 
	y = 25.0;  // yの初期値の設定 
	dx = 0.01; // xの変化量
	int n = 10; //プロット回数
	for(int i=0;i<n;i++){
		y += dy_dx(x,y)*dx;
		x += dx;
		cout << x << "\t" << y << endl;
	}
}