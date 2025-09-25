#   **Arm Elevation Viewer – Version 2020.1**
<img width="1282" height="796" alt="Screensh-full window" src="https://github.com/user-attachments/assets/f577c619-7e65-4b10-8f3f-076d5a6de264" />


**© 2020, Pasan Hettiarachchi & Peter Johansson**

**Occupational and Environmental Medicine, Uppsala University, Sweden**

## Implementation details
This software tries to replicate the accelerometer-only (without full IMU) arm-elevation finding algorithm used in the article ["An iPhone application for upper arm posture and movement measurements"](https://doi.org/10.1016/j.apergo.2017.02.012) by Liyun Yang et al. in MATLAB for used with Axivity AX3 accelerometers. Consider this as a draft first implementation and use this tool (if you must 😀) with abundance of caution. Furthermore, it should be pointed out simple arm-elevation finding (which uses just inclination with respect to gravity) with a single zero-reference-position correction, may not be adequate and dual-angle reference position correction (both zero and 90 degrees) is perhaps preferable. See: [Is what you see what you get? Standard inclinometry of set upper arm elevation angles](https://doi.org/10.1016/j.apergo.2014.08.014) by Jennie Jackson et al.

## Not for commercial use. For redistribution, please contact the authors.
**Contact:**
pasan.hettiarachchi@medsci.uu.se or peter.johansson@medsci.uu.se

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## License
Unless otherwise specified in an individual file, the source code is released under LGPL license.
