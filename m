Message-ID: <50F736EF.1090303@...1800...>
Date: Wed, 16 Jan 2013 18:25:35 -0500
From: Mike Tancsa <mike@...1800...>
MIME-Version: 1.0
References: <1CED409804E2164C8104F9E623B08B901323A48384@...1436...>
	<50F7257C.9010404@...1800...> <50F73264.2070608@...1114...>
In-Reply-To: <50F73264.2070608@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Fix --show-pkcs11-ids
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: =?ISO-8859-1?Q?Samu?=

On 1/16/2013 6:06 PM, David Sommerseth wrote:
> On 16/01/13 23:11, Mike Tancsa wrote:
> 
> $ git tag --contains fd02ae905df21e1119fb63521e7ff773d6f812dc 
> v2.3.0 v2.3_rc2
> 
> 
> However, it seems that the generic build tool needs some more
> tweaking to grab the packages correctly from github - they changed
> the download URLs.  Might be more issues there as well.
> 
> Samuli, can you check this?
> 
> How I compile OpenVPN is basically directly from the git tree,
> with these steps:
> 
> $ autoreconf -vi
Hi,
	I think for me, the issue was in the initial cloning of the repo.

Looking at
https://github.com/OpenVPN

I see
https://github.com/OpenVPN/openvpn
updated 10 days ago

But the instructions point to
https://github.com/OpenVPN/openvpn-build

which was updated 6 months ago

	---Mike

-- 
-------------------
Mike Tancsa, tel +1 519 651 3400
Sentex Communications, mike@...1800...
Providing Internet services since 1994 www.sentex.net
Cambridge, Ontario Canada   http://www.tancsa.com/

