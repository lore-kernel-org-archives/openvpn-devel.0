Message-ID: <54239676.2060402@...1856...>
Date: Thu, 25 Sep 2014 06:13:42 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <373411786.14344069.1411476345082.JavaMail.zimbra@...1347...>
In-Reply-To: <373411786.14344069.1411476345082.JavaMail.zimbra@...1347...>
Subject: Re: [Openvpn-devel] OCSP_check.sh fixup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi Hubert,

On 23-09-14 14:45, Hubert Kario wrote:
> There are few serious issues with the OCSP_check.sh script:
>  1. It will accept OCSP responses with bad signatures
>  2. It may accept OCSP old responses as currently valid
> 
> detailed description on bug tracker:
> https://community.openvpn.net/openvpn/ticket/450#ticket
> 
> Pull request with fixes:
> https://github.com/OpenVPN/openvpn/pull/17

Thanks.

OpenVPN uses a patch review mechanism that requires all patches to be
sent to this mailinglist (see
http://community.openvpn.net/openvpn/wiki/DeveloperDocumentation). Could
you pleases send your suggested changes (as one or two patches) to this
mailinglist? (git format-patch is your friend). Once the patches are on
the mailinglist, we can do the final code review.

Anticipating on the actual review, your suggested changes sound good to
me. Normally we'd have to be careful not to break existing setups, but
since this script has been broken for quite a while (and has only been
fixed recently) it appears to be not used very often. So I think it is
fine to change the behaviour like this.

-Steffan

