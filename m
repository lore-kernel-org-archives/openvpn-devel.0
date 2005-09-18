From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] openvpn-2.0.2-pkcs11-20050916.patch
In-Reply-To: <432DCAB4.9080503@...277...>
Message-ID: <Pine.LNX.4.58.0509182351540.11393@...41...>
References: <432DCAB4.9080503@...277...>
MIME-Version: 1.0
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
Date: Sun Sep 18 23:22:13 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, 18 Sep 2005, Alon Bar-Lev wrote:

> Update:
> 
> The patch was tested on Windows (Base, no GUI).
> 
> HOWTO was written, can be found on:
> 
> http://sourceforge.net/tracker/index.php?func=detail&aid=1293066&group_id=48978&atid=454721
>
> Please feel free to correct my English.

Thanks, though I was thinking about a document which would contain a full 
sequence of steps for taking a sample OpenVPN configuration and turning 
it into a dual-factor setup, using a smartcard.

Something that would integrate as a section in the current 2.0 HOWTO, such 
as "How to add dual-factor authentication to an OpenVPN configuration 
using client-side smartcards".

It would answer questions such as:

(1) some discussion about why the smart-cards improve security

(2) which smart-card products are PKCS11-compatible or links to the same 

(3) system requirements, such as minimum version of OpenSSL

(4) how to configure the cards

(5) how to modify OpenVPN client and/or server configuration to make
use of the cards

(6) While this goes beyond the PKCS11 discussion, some people are going to
be interested/confused by the differences between the PKCS11 functionality
you've added and the existing Windows Crypto API support, as a means for
using smartcards with OpenVPN.

> I am waiting for reply regarding your request to merge external include 
> files into root.

I think it's reasonable to keep the external include files in their own 
directory if you think it makes the source file organization cleaner.

Just make sure that it doesn't break anything, such as "make dist" to
build tarballs, and the Windows build environment.

James

