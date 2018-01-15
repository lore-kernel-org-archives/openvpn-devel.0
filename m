Message-ID: <1516058323.3169.59.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Mon, 15 Jan 2018 15:18:43 -0800
In-Reply-To: <CAKh=nwGiHTZj8MqN6LmYjCAVAxGurOeatV8eVMPeELAGcXVXsg@...278...>
References: <CAKh=nwF5PZ2CbEARe7-D=0dxt-XjRR-+2Z=16pENVzzxfgZM8A@...278...>
 <707c4845-6d3b-e9ba-0e8a-36f27d85bab3@...1856...>
 <CAKh=nwEFfwQnRTMc1D-4tb8DWOpJOPPD82fBZ2pRwNYdihJA8g@...278...>
 <9491d49e-a858-b3ad-21ab-1ee3b86ef41a@...1856...>
 <CAKh=nwGiHTZj8MqN6LmYjCAVAxGurOeatV8eVMPeELAGcXVXsg@...278...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] PKCS#11 - a little bit of help?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Emmanuel Deloget <logout@...260...>, Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, 2018-01-16 at 00:07 +0100, Emmanuel Deloget wrote:
> While the number of required changes were quite small (and have no
> impact on openvpn), this was quite a journey. I guess some of the
> merits should go to RSA, Microsoft and Intel, for their incredible
> effort in building comprehensive industry standards that are as
> convoluted as they are comprehensive :) (I'm kidding ; I think I
> begin to enjoy PKCS#11 and I definitely had some fun while playing
> with my TPM2).
> 
> Those who are interested can contact me. I will probably try to
> write something about this somewhere (I don't know where yet).

Just a note that there is an easier way of doing this.  The engine key
patch:

https://sourceforge.net/p/openvpn/mailman/message/36147533/

Achieves the same thing somewhat more simply.  You use the tpm2 engine:

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/

And convert an existing private key into engine format with
create_tpm2_key and place it in /etc/openvpn/ where the private key
file usually goes.  Then all private key signature transactions go via
the TPM.

James


