From: Heiko Hund <heiko@...2662...>
Date: Fri, 03 Feb 2023 15:34:02 +0100
Message-ID: <5855161.DvuYhMxLoT@...2664...>
In-Reply-To: <20230131135248.3574741-1-arne@...1227...>
References: <20220909195902.2011798-1-arne@...1227...>
 <20230131135248.3574741-1-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v7] Dynamic tls-crypt for secure
 soft_reset/session renegotiation
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

On Dienstag, 31. Januar 2023 14:52:48 CET Arne Schwabe wrote:
> Patch v7: also xor tls-auth key data into the dynamic tls-crypt key like
>           tls-crypt key data

I've tested this with the openvpn3 implementation thoroughly in combination 
with --tls-auth, --tls-crypt and without any wrapping of the control channel 
and found everything working as intended, hence:

Acked-by: Heiko Hund <heiko@...2662...>
 
Only this last little quirk:

> +Dynamic TLS Crypt
> +    When both peers are OpenVPN 2.6.0+, OpenVPN will dynamically create

maybe can be changed during merge to 2.6.1+ or whatever will fit.



