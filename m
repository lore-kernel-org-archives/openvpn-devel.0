From: Arne Schwabe <arne@...1227...>
References: <20210904095629.6273-1-a@...2181...>
 <20210904095629.6273-2-a@...2181...>
 <56febc9b-ca20-9b12-1a54-0f1a6c79cf8c@...1227...>
Message-ID: <4b4333be-7257-ffeb-8f11-8ebfd2b9320d@...1227...>
Date: Tue, 7 Sep 2021 13:10:02 +0200
MIME-Version: 1.0
In-Reply-To: <56febc9b-ca20-9b12-1a54-0f1a6c79cf8c@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 1/7] simplify condition detecting pure
 P2P mode
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net


> 
> Yes. Makes sense. The change makes it is a lot more clear. I think it is
> actually not equivalent but the new one is definitively the correct one.
>

I looked at the code again and I have to actually retract my ACK.

The previous code means P2P mode with static key or P2P mode without
--pull while the new condition means only P2P mode with static key.


The code that follows for that section should be better commented:

        if (!o->ciphername)
        {
            o->ciphername = "BF-CBC";
        }
        else
        {
            o->enable_ncp_fallback = true;
        }
        return;

It basically condeses to having always a valid string in o->ciphername,
which is then used in static key code (which ignores data-ciphers) or
allowing falling back to the cipher explicitly set via --cipher if we
are in TLS mode (with NCP) but not to the implicit BF-CBC.

Arne

