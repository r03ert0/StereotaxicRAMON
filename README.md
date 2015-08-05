StereotaxicRAMON
================

__General commands__
---
<dl>
<dt><b>commands</b></dt>         <dd>List all commands</dd>
<dt><b>help</b>(name)</dt>       <dd>Print help on command a command</dd>
<dt><b>penSize(size_in_pixels)   </b></dt><dd>Arg[1]=size in pixels</dd>
<dt><b>setMouse(mouse_mode)      </b></dt><dd>Change mouse mode to arg[1]={sample,paint,select,cselect,poly,fill}</dd>
</dl>

__Commands acting the volume data__
---
<dl>
<dt><b>abs                                           </b></dt><dd>Absolute value</dd>
<dt><b>addConstant(value)                            </b></dt><dd>Add 'value' (a float number) to the volume values</dd>
<dt><b>multiplyConstant(value)                       </b></dt><dd>Multiply the volume values by arg[1]</dd>
<dt><b>applyRotation                                 </b></dt><dd>Apply current rotation</dd>
<dt><b>boxFilter(filter_size,iterations)             </b></dt><dd>Arg[1]=filter size, arg[2]=iterations</dd>
<dt><b>changePixdim(dim_x,dim_y,dim_z)               </b></dt><dd>Change voxel dimensions in the header</dd>
<dt><b>convertToMovie(path)                          </b></dt><dd>Convert slices into mp4 movie stored at path arg[1]</dd>
<dt><b>crop                                          </b></dt><dd>Crops volume to the bounding box of the selection</dd>
<dt><b>mode                                          </b></dt><dd>Change value of each voxel in the selection by the mode of a neighbourhood of size 7x7x7</dd>
<dt><b>polygonize(path)                              </b></dt><dd>Save a mesh of the selection at arg[1]=path</dd>
<dt><b>reorient(new_orientation)                     </b></dt><dd>Change the current 'xyz' orientation of the volume to that of the string in arg[1], for example, zxy</dd>
<dt><b>resample(x_dim,y_dim,z_dim,interpolation)     </b></dt><dd>Resample volume to pixel dimensions arg[1-3], using arg[4]={nearest,trilinear} interpolation</dd>
<dt><b>resize(x_dim,y_dim,z_dim,justification)       </b></dt><dd>Resize volume to dimension arg[1-3], arg[4]=three characters containing the justification flags s=start, c=center, e=end for the x, y and z dimensions (for example ssc=x start, y start, z center)</dd>
<dt><b>save                                          </b></dt><dd>Overwrite volume</dd>
<dt><b>saveAs(path)                                  </b></dt><dd>Save data volume at arg[1]=path</dd>
<dt><b>savePicture(path)                             </b></dt><dd>Save current image at arg[1]=path</dd>
<dt><b>set(value)                                    </b></dt><dd>Set the selected voxels to 'value'</dd>
<dt><b>setRotation(x_rotation,y_rotation,z_rotation) </b></dt><dd>Rotate the volume arg[1-3]=angle x, y, z, in degrees</dd>
<dt><b>setVolume(path)                               </b></dt><dd>Reload volume</dd>
<dt><b>stdev(neighbourhood,maximum)                  </b></dt><dd>Replaces volume by the local standard deviation of its values, clipping the maximum</dd>
</dl>

*Mathematical morphology operators*
<dl>
<dt><b>dilate(size_in_voxels)                      </b></dt><dd>Dilate selection arg[1]=number of voxels</dd>
<dt><b>erode(size_in_voxels)                       </b></dt><dd>Erode selection arg[1]=number of voxels</dd>
<dt><b>tpDilate(size_in_voxels)                    </b></dt><dd>Topology-preserving dilate selection arg[1]=number of voxels</dd>
<dt><b>tpDilateOnMask(size_in_voxels,path_to_mask) </b></dt><dd>Topology-preserving dilate selection inside a mask, arg[1]=number of voxels, arg[2]=path a mask with the same dimensions as the current volume</dd>
<dt><b>tpErode(size_in_voxels)                     </b></dt><dd>Topology-preserving erode selection arg[1]=number of voxels</dd>
</dl>

*3D Fourier transform*
</dl>
<dt><b>dct                                           </b></dt><dd>Direct cosine transform</dd>
<dt><b>idct                                          </b></dt><dd>Inverse discrete cosine transform</dd>
</dl>

*Measure*
<dl>
<dt><b>minMax                                        </b></dt><dd>Print minimum and maximum values</dd>
<dt><b>histogram                                     </b></dt><dd>Histogram of volume's selected values</dd>
<dt><b>info                                          </b></dt><dd>Display file header information</dd>
<dt><b>stats                                         </b></dt><dd>Prints summary statistics of the selection</dd>
</dl>

__Commands acting on the selection__
---
<dl>
<dt><b>addSelection(path)                                  </b></dt><dd>Add selection from arg[1]=path</dd>
<dt><b>loadSelection(path)                                 </b></dt><dd>Load selection at arg[1]=path</dd>
<dt><b>saveSelection(path)                                 </b></dt><dd>Save selection at arg[1]=path</dd>
<dt><b>subtractSelection(path)                             </b></dt><dd>Subtract selection from arg[1]=path</dd>
<dt><b>boundingBox                                         </b></dt><dd>Select the smallest box including all currently selected voxels</dd>
<dt><b>box(xmin,ymin,zmin,xmax,ymax,zmax)                  </b></dt><dd>Select the region inside the box arg[1-6]=xmn,ymn,zmn,xmx,ymx,zmx</dd>
<dt><b>connectedSelection(x,y,z)                           </b></dt><dd>Keeps only the selection connected to coordinate x,y,z</dd>
<dt><b>deselect                                            </b></dt><dd>Clears the selection</dd>
<dt><b>euler                                               </b></dt><dd>Display Euler's characteristic for the selection</dd>
<dt><b>fill(x,y,z,plane)                                   </b></dt><dd>Fills in 2D starting at coordinates arg[1-3]=x,y,z in plane arg[4]=X, Y or Z</dd>
<dt><b>grow(min,max)                                       </b></dt><dd>Add to the actual selection connected voxels with values between arg[1,2]=min,max</dd>
<dt><b>make26                                              </b></dt><dd>Remove edge and corner neighbours so as to make the selection 26 connected</dd>
<dt><b>invert                                              </b></dt><dd>Invert selection</dd>
<dt><b>select(x_coord,y_coord,z_coord,min_value,max_value) </b></dt><dd>Select voxels around x_coord,y_coord,z_coord with values within min_value and max_value</dd>
<dt><b>setThresholdWidth(width)                            </b></dt><dd>Expand the threshold to include values within the width</dd>
<dt><b>smooth(threshold,n_iterations)                      </b></dt><dd>Smooth selection by removing all voxels with less than threshold, for n_iterations</dd>
<dt><b>threshold(value,direction)                          </b></dt><dd>Select values from arg[1]=threshold and down if arg[2]=0 or up if arg[2]=1</dd>
<dt><b>undo                                                </b></dt><dd>Undoes as much as possible of the previous action</dd>
</dl>

__Display__
---
<dl>
<dt><b>adjustMinMax                      </b></dt><dd>Adjust min and max grey level values to mean ± 2 standard deviations (clipped to the volume's min and max)</dd>
<dt><b>colormap(name)                    </b></dt><dd>Colormap name is a string among {autumn, bone, winter, hot, water, solidred, solidrgb, jet, jetrgb, negpos, gray}</dd>
<dt><b>setMinMax(min,max)                </b></dt><dd>Change the min,max values used for display to arg[1,2]=min,max</dd>
<dt><b>setSelectionColor(red,green,blue) </b></dt><dd>Change selection color to RGB=arg[1-3]</dd>
<dt><b>setSelectionOpacity(opacity)      </b></dt><dd>Change selection opacity to arg[1]</dd>
</dl>

__Mesh commands__
---
<dl>
<dt><b>flipMesh(plane)               </b></dt><dd>Flips the mesh (if loaded) along the dimension argv[1]=x, y or z</dd>
<dt><b>loadMesh(path)                </b></dt><dd>Load a mesh in text format at arg[1]=path</dd>
<dt><b>pushMesh(distance)            </b></dt><dd>Push the mesh (if loaded) by arg[1]=distance along the normal</dd>
<dt><b>reorientMesh(new_orientation) </b></dt><dd>Change the current 'xyz' orientation of the mesh (if loaded) to that of the string in arg[1], for example, zxy</dd>
<dt><b>saveMesh(path)                </b></dt><dd>Save mesh (if loaded) at arg[1]=path</dd>
<dt><b>scaleMesh(value)              </b></dt><dd>Scale mesh (if loaded) with arg[1]=scale factor</dd>
<dt><b>translateMesh(x,y,z)          </b></dt><dd>Translate mesh (if loaded) by adding arg[1-3]=x, y and z displacements</dd>
<dt><b>voxeliseMesh                  </b></dt><dd>Voxelise mesh (if loaded)</dd>
</dl>