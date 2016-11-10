References: <1478636302-9678-1-git-send-email-steffan.karger@...1435...>
	<1478636302-9678-2-git-send-email-steffan.karger@...1435...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <a173b65e-98dd-4a77-2c92-42692cbb0a07@...1227...>
Date: Thu, 10 Nov 2016 16:50:54 +0100
MIME-Version: 1.0
In-Reply-To: <1478636302-9678-2-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] Refactor static/tls-auth key loading
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
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

Am 08.11.16 um 21:18 schrieb Steffan Karger:
> Remove duplicate code, in preparation for adding --tls-crypt, which
> otherwise would have to duplicate this code again.
> 
> This should be equivalent to the old code, except for two things:
> * The log lines for static key initialization change slightly, from
>   "Static Encrypt/Decrypt" to "Incoming/Outgoing Static Key Encryption"
> * We also 'check and fix highly unlikely key problems' for tls-auth
>   keys (boils down to a sanity-check for an all-zero key).

Looks good. ACK to this one.

Arne


