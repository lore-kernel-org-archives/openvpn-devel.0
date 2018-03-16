MIME-Version: 1.0
In-Reply-To: <20180316164059.9120-1-xiaoningning@...109...>
References: <20180316164059.9120-1-xiaoningning@...109...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 16 Mar 2018 13:30:24 -0400
Message-ID: <CAKuzo_h9=+BeTmg5t=H9nUQbqqi8r4DFd7oPrSBOSArQepj3_w@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Increase TLS Control Channel Buffer Size
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Ning Wei <xiaoningning@...109...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Apologies in advance if I'm misreading the intent of this patch.

On Fri, Mar 16, 2018 at 12:40 PM, Ning Wei via Openvpn-devel
<openvpn-devel@lists.sourceforge.net> wrote:
> Increase TLS_CHANNEL_BUF_SIZE to 4096. When the build is enabled with
> ENABLE_PKCS11, the password field can be 4096.  The old size of
> TLS_CHANNEL_BUF_SIZE was 2048, which is not enough.

I do not follow the logic behind this. Sure, ENABLE_PKCS11 increases the
password buffer size to 4096, but pkcs11 password is only consumed
locally, not sent out to the remote.

Now, even if a auth-user-pass password or challenge response gets as
large as 4096 bytes, there are other places in the code that
need "fixing" to permit such long "passwords" (or response) -- e.g., it cannot
be submitted via the management as the parser expects a max line
length of 255 and word length of 255.

Further, even a TLS_CHANNEL_BUF_SIZE of 4096 does not support a
password that long as there are other things like username, key-source,
local-options that have to fit into the buffer (see key_method_2_write). So
what's the logic behind 4096?

Finally, are there any particular challenge-response framework that requires
such long responses? Even for U2F, we wouldn't need to send a response
that large. U2F registration response could get very long (still mostly under
2000 bytes), but doing U2F key registration via the authentication channel is
not a good implementation. Authentication responses are much smaller.

In short, it looks premature to increase this value before we start
supporting long responses via the management, and a real practical
need for long challenge response strings that won't fit in the current
2048 bytes (minus overhead) arise.

Selva

