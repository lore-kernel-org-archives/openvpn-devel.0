Resent-To: "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Resent-Message-ID: <b8ebc89d-4467-0b24-b4bc-62bf3c8012dd@...2162...>
References: <1484772172-19758-1-git-send-email-selva.nair@...277...>
	<20170120181647.10199-1-davids@...515...>
	<CAKuzo_iuwKbWwTsRP4PV+-5NRFOkjyY6LtCKEbzT7ETEjysZ+g@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <c463b2db-ffc1-20ab-3218-f2bb488977c4@...2080...>
Date: Fri, 20 Jan 2017 22:07:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iuwKbWwTsRP4PV+-5NRFOkjyY6LtCKEbzT7ETEjysZ+g@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Add a check for -Wl,
 --wrap support in linker
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 20/01/17 21:38, Selva Nair wrote:
> 
> On Fri, Jan 20, 2017 at 1:16 PM, David Sommerseth
> <davids@...515... <mailto:davids@...515...>> wrote:
> 
> Your patch has been applied to the following branches
> 
> commit f91ab283a407e25c4b32aecb390911b212ce2694  (master) commit
> 2f5f1d8fffcba26d21d47cbcb1e99e0e1c313568  (release/2.4)
> 
> 
> I am curious to know whether the opensolaris buildbot (there is
> one isn't it?) run and pass all tests?

We have a few opensolaris builds getting kicked off.  If ignoring a
temporary and odd t_client.sh error on one of the OSX builds,
everything built correctly now without any issues.

TL;DR: Buildbot haven't had so many green cells as it has now in a
long time.  So I'm happy, and I believe Gert is happy too!


- -- 
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYgnv6AAoJEIbPlEyWcf3yFJgP/163RFBSB5kNx4lr1+3CaNwz
d/TDeX10/exjFZUZm0H3IbcN/VfFk+3IscIEOVOq0O4sQm9t6uRzP+zHKZhvulUd
K98Lu/dBjZ86shrUmjelDJ6lo5grKcuPnOxkRrRA1GQY8CWoWdj+S2oyyT+I6Ji1
n710ddg8Z6QOSnajSLP6Mvj5kT4KVy2d7Wpg7rUyrtZINL7G/ntKO29ScdemWyTl
EtdlXiCcXPzmsnIeP0wrGQDmCs5hehSHa7LgchwPL33HNdnKejaqAT7oyyZJtSX3
3CHxUntFE1dJ6jTArcO7eMbnxHvEX4yyIZ2fn+sMcXuCyACw7lpdFi47BCH4u1ou
g0ulTQHi220O3ckjP2U9+wqzzZiSZLao6K8vra6r9PvLF/SeIF9l2bY1YS6riSBt
W76zoMbI65Jdin8ooheODqxVLEDR7ctMiu6qO7jIGjlMC89t1pVb2yQ8EInl6EVi
0Zcl83n58irN2Z6eD7PDjThaHNYWn76daVW4cJuJvkLzNvX6DB0c0uOiNJkd4RRe
0ECjBi7ATlBy4L1yJoL86MYCr5qRPeEMRfakqP2jWwrX92JNF5tzllEJ9m7gLjyO
dJaNvAtNu1uF3swHk/HDHRLi9vwz/92qbuje5ChUrM/XeLCxT6UouMr2IYaIzrYJ
JUdSpsjnygKNaRYxXU3M
=7QMK
-----END PGP SIGNATURE-----

