#!/usr/bin/python

import sys, getopt
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import numpy as np
import pdb

#returns image name from arguments from command line, if no image specifiec throws an error
def get_imagename():

	inputfile = ''

	try:
		opts, args = getopt.getopt(sys.argv[1:], 'i:' )
	except getopt.GetoptError as err:
		print str(err)
		usage()
		sys.exit(2)
	
	for o, a in opts:
		if o == "-i":
			inputfile = a

	if inputfile == '':
		raise Exception("Please specify an image")


	return inputfile


#accepts an image name and plots the image
#user will pick 4 points on image and lines are drawn between the points
def plot_image(image_name, num_pts):

	for i in range(num_pts):
		print "hi"

	img = mpimg.imread(image_name)
	
	plt.imshow(img)
	
	
	x = []
	y = []

	for i in range(num_pts):
		print "Point:" + str(i)
		pt = plt.ginput(1)
		ptx, pty = pt[0]
		x.append(ptx)
		y.append(pty)

		#you have > 1 pts, start drawing lines
		if(i > 0):
			line = plt.Line2D( (x[i-1], x[i] ), ( y[i-1], y[i] ) )
			plt.gca().add_line(line)
			#line is drawn after plotting
			plt.draw()

	


		#draw line between

	

def main():

	num_pts = 4;
	im1 = get_imagename()
	plot_image(im1, num_pts)







if __name__ == '__main__':
	main()