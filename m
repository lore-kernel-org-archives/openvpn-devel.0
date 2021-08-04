References: <20210802133127.25000-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <b89251f0-02b8-cbc1-3292-f3cc7031a640@...2181...>
Date: Wed, 4 Aug 2021 11:31:05 +0200
MIME-Version: 1.0
In-Reply-To: <20210802133127.25000-1-gert@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Ignore --explicit-exit-notify in TCP
 mode.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 02/08/2021 15:31, Gert Doering wrote:
> Mixed udp+tcp configs can not have --explicit-exit-notify in them
> today because this option is refused in TCP mode.  At the same time,
> it was always possible to push the option both in UDP and TCP mode
> (with a warning logged in TCP mode, and the option reset to 0).
> 
> Do the same thing for local config - warn, and reset to 0.
> 
> (Leaving it enabled in TCP mode is harmless, but causes extra error
> messages in the log which is undesired behaviour.  Maybe one should
> just fix the underlying logic for TCP mode instead, but this is more
> invasive)
> 
> Signed-off-by: Gert Doering <gert@...1296...>

I gave this patch a run in various udp/tcp combinations and it all
looked good to me.

Having both:

proto tcp
explicit-exit-notify

in the client config does not lead to any fatal error anymore.
The client logs the fact with a NOTICE and moves on.

If the server will also push explict-exit-notify, the client will log
once again, as always happened (this behavior wasn't modified).

The same behavior can be observed on the server side.

Code change looks good and small enough :)

Acked-by: Antonio Quartulli <antonio@...515...>

-- 
Antonio Quartulli

