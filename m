Message-ID: <432DCAB4.9080503@...277...>
From: Alon Bar-Lev <alon.barlev@...277...>
Reply-To: alon.barlev@...277...
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] openvpn-2.0.2-pkcs11-20050916.patch
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Sep 18 13:28:04 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: openvpn-devel@lists.sourceforge.net

Update:

The patch was tested on Windows (Base, no GUI).

HOWTO was written, can be found on:

http://sourceforge.net/tracker/index.php?func=detail&aid=1293066&group_id=48978&atid=454721

Please feel free to correct my English.


I am waiting for reply regarding your request to merge external include 
files into root.


Regards,

Alon Bar-Lev.


On 9/17/05, James Yonan <jim@...41...> wrote:
 > On Fri, 16 Sep 2005, Alon Bar-Lev wrote:
 >
 > This is very cool -- thanks for your efforts.  We'll plan on merging this
 > when the 2.1 beta series starts up.

Thanks!

 >I'd like to see some Windows testing as well.

Do you know a developer with windows environment that uses smartcard?
I just don't have a development environment for windows... I can make
one if there is no one to test it.
The code it-self was tested under windows, but not as a whole.

If you run openvpn as a service do you get prompted for password
(--askpass) by the management component? Does the GUI know to popup
this password request? If I understood correctly this what happens...

 >
 > If you don't mind, it would also be great if you could put together a
 > mini-HOWTO on this.

I will.

 > Make sure that it's easy to #ifdef out all the pkcs11 stuff, if people
 > don't want it.  This is mostly for the embedded crowd who are very
 > sensitive to code size.  Notice how almost every major non-core 
option can
 > be selectively disabled:

OK, I will.

 > The other minor point is that you add a pkcs11 directory in the source
 > distribution root for some header files.  Right now, just to stay
 > consistent with the current source file organization, could you keep 
those
 > files in the root as well?  (I know that means that you'll end up 
with two
 > pkcs11.h files, so one would need to be renamed)

I've done this intentionally...
The include files in the pkcs11 directory are taken from RSA Security
and not part of openvpn development. I think that it is good practice
to separate external files for internal ones.
Please tell me if you don't agree so I will merge them into the root.

Best Regards,
Alon Bar-Lev.


