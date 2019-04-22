References: <CAPM6dUC_L=Q2HseFEKS7bfrff6McwQo9TSuWKramkbC+5k9Phw@...278...>
 <5d43db38-5481-3f67-555d-b2b59b89be63@...1147...>
 <CAFHpkQEetMrGST3DziN5gedP32DbN4v7w+NDmViZcccmaZf7Fg@...278...>
 <CAPM6dUBfeuEnfqW59YBNdtRDMhWfSc_9NXSsxuKskPzqK=4qVA@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <55089415-3a26-8bf1-f23d-62dc6f0fcc7d@...1227...>
Date: Mon, 22 Apr 2019 04:51:46 +0200
MIME-Version: 1.0
In-Reply-To: <CAPM6dUBfeuEnfqW59YBNdtRDMhWfSc_9NXSsxuKskPzqK=4qVA@...278...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] openvpn with udp lost event.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: wei wang <lnykww@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 20.04.2019 um 10:37 schrieb wei wang:
> Thanks for your guys reply.
>
> The correct thing is that synchronous authentication increases the
> probability of event loss.
> But deferred auth is not what we need, we need deferred client-connect actually.
> I have found that the patch set
> "https://patchwork.openvpn.net/project/openvpn2/list/?series=413" has
> implement it.
> But it has not been updated for several months. Is there someone still
> work on it?  We test with it for client-connect script, and find some
> bug.
> I am very happy to provide if needed.
>
Yes, any review and testing is appricated. Note that this patch set is
already version 4 so it should be pretty stable and safe for production use.

Arne


