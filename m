MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
From: Emmanuel Deloget <logout@...260...>
Date: Fri, 17 Feb 2017 17:35:04 +0100
Message-ID: <CAKh=nwGz-NSEcSY9KhQ12gC1GNXP6XOBTEO3FdP8gyJN5VTggg@...278...>
Subject: Re: [Openvpn-devel] build against openssl 1.1.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello,

First, sorry for the inconvenience: this message is not attached to
the remaining of the discussion (I just joined the ML so I cannot
answer to a one week old message). That being said:

On Mon, Feb 13, 2017 at 08:17:58PM +0100, Christian Hesse wrote:
> Arch Linux is about to upgrade openssl to version 1.1.0. OpenVPN does not
> compile against this version. Did anybody start the work to support latest
> openssl versions?

I did (yesterday). So far, I made good progress on many front,
although I'm not sure the path I took is what you would expect.

One of the main change in OpenSSL 1.1 is that types are now opaque,
meaning that you need to access the internal fields using various
(mostly short) functions. For most of them, these functions has been
added to the API.

To make OpenVPN support OpenSSL, I decided to

  1. check whether the functions I need are in OpenSSL at configure
time. The function list is quite large.
  2. reimplement the missing functions as static inlines in an
openssl_compat.h header, using the OpenSSL prototypes.
  3. use the new interface in the OpenVPN code.
  4. when possible (i.e. when the interface already exists in OpenSSL
1.0), use this interface

The motivation behind this is to ease the porting of OpenVPN to a new
OpenSSL API -- if the code is already using the latest API, the next
changes are going to be less radical.

Having done 2/3 of the job, the patch set is about +900 insertion,
-200 deletion (or something like that). I still have a lot of things
to do and I should finish my first pass at the beginning of newt week.
I don't expect the patch set to be much longer than it already is.

Now, I have a question which is related to this. The way I'm doing
things, I will make sure that the new code is compatible with both
OpenSSL 1.0.x and OpenSSL 1.1. There is a good chance that it will be
compatible with version 0.9.8 as well, yet I can't stop wondering if
this is a good thing. OpenSSL 0.9.8 has been EoL'ed 12 month ago and I
believe it's OK to let it die. OpenVPN cannot rely on a dead SSL
library -- unless it wants to make sure that future vulnerabilities in
this old, deprecated version will affect it (and I'm not sure it's a
good thing). Same goes for OpenSSL 1.0.1 which has been declared out
of support in January 2017.

I understand that I'm the new guy in town, but can you allow me to
make the formal request to ditch OpenSSL 0.9.8, 1.0.0 and 1.0.1 and
require at least version 1.0.2?

Best regards,

-- Emmanuel Deloget

