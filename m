Message-ID: <4DA70AF3.5020103@...1114...>
Date: Thu, 14 Apr 2011 16:55:47 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4D91BF5B.9070100@...1114...>
	<20110409162438.GE8496@...1296...>
In-Reply-To: <20110409162438.GE8496@...1296...>
Subject: Re: [Openvpn-devel] man page updates needed for the coming OpenVPN
 2.2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/04/11 18:24, Gert Doering wrote:
> Hi,
> 
> On Tue, Mar 29, 2011 at 01:15:39PM +0200, David Sommerseth wrote:
>> I have checked the man page against the options OpenVPN 2.2 supports and
>> cross-checked it against the man page.  There are quite some features which
>> are not documented at all in the man page, and this should be fixed.
>>
>> <https://community.openvpn.net/openvpn/wiki/ManPageUpdatesFor2.2>
> 
> As agreed in last thursday's IRC meeting, I've added a comment to the
> code explaining "--rdns-internal".  It's really very much an internal
> option, so it does not need to go to the man page.
> 
> gert
> ---
> From 55cdbb7e67db3b98723917fd9810a94874d8de21 Mon Sep 17 00:00:00 2001
> From: Gert Doering <gert@...1296...>
> Date: Sat, 9 Apr 2011 18:16:21 +0200
> Subject: [PATCH] add more detailed explanation regarding the function of "--rdns-internal",
>  as agreed on the IRC meeting.
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  options.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 

ACK!  Pushed to master and cherry-picked for beta2.2.

commit cdb3a5c0864e0fe8d0b814de1f024fd624dd3b1c
Author: Gert Doering <gert@...1296...>
Date:   Sat Apr 9 18:16:21 2011 +0200


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2nCvEACgkQDC186MBRfrquwwCglL9McRbJRLiaOnuuR8TbTb0p
5g8AniEWlzo3eVn1Hftbnf+dr0f9egkb
=wHNy
-----END PGP SIGNATURE-----

