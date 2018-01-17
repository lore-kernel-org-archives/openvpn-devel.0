References: <1515959073-10376-1-git-send-email-selva.nair@...277...>
 <1515959073-10376-3-git-send-email-selva.nair@...277...>
 <e059b07e-5684-1dbe-cfdf-1271efc594dc@...1227...>
 <CAKuzo_jN9EOK5aPr2dn+m+ynarY-Snt2pwOmz9cV32BpKSFq=w@...278...>
 <CAKuzo_hYwcRDJjYW7i=Ekmi93TAXRb+n=sNyi4y=+gS+vbbtAA@...278...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <caf0faaa-428f-29c4-797f-8be8ac4f0f47@...1435...>
Date: Wed, 17 Jan 2018 09:53:23 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hYwcRDJjYW7i=Ekmi93TAXRb+n=sNyi4y=+gS+vbbtAA@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 2/3] Allow external EC key through
 --management-external-key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 17-01-18 05:24, Selva Nair wrote:
> Also I'm toying with the idea of renaming ecdsa-sig/ECDSA-SIGN by
> pkey-sig/PKEY-SIGN so that eventually we may be able to use it for
> all types of keys and retire rsa-sig. Any thoughts on that?

This was my first though when looking at these patches.  Haven't looked
at the code yet, but functionally I think that's the way to go.  Even if
it were that Ed25519 / Ed448 sigs are technically not ECDSA sigs.

I'll look into these great patches more later.

-Steffan

