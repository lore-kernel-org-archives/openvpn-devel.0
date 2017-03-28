References: <ec21d010-67a3-0ff1-3c2a-d5db08039e45@...277...>
	<20170327183502.GJ93896@...1296...>
	<CAKh=nwE-U4C6CVw+XpdBE1RXjG_VOYoT=UuJDAPs2AOFOoP+jw@...278...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <668fd081-d9b4-1727-f506-07395cf0b475@...1435...>
Date: Tue, 28 Mar 2017 10:39:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAKh=nwE-U4C6CVw+XpdBE1RXjG_VOYoT=UuJDAPs2AOFOoP+jw@...278...>
Subject: Re: [Openvpn-devel] building HEAD + openssl 1.1 api fails @
 "crypto.c:823:32: error: invalid application of ???sizeof??? to incomplete
 type ???cipher_ctx_t"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 28-03-17 10:33, Emmanuel Deloget wrote:
> ​I should be able to push a new version of the remaining patches in the
> foreseeable future (let's say today or tomorrow, because I will be
> unavailable at the end of this week).
> 
> I found a solution to overcome the big X509_check_purpose() issue, so
> now I'm able to propose a solution that does not change the behavior of
> OpenVPN.

That's great!  This way, 2.4 does not have to change it's behaviour.
Still, I think it makes sense to deprecate --ns-cert-type, and remove it
in favour or --remote-cert-tls in openvpn 2.5.

-Steffan


