MIME-Version: 1.0
References: <20260315184337.1541272-1-luca.boccassi@...277...>
 <20260315184337.1541272-2-luca.boccassi@...277...>
 <8573cf46-0e95-41ee-bb9f-53138747ff45@...1227...>
In-Reply-To: <8573cf46-0e95-41ee-bb9f-53138747ff45@...1227...>
From: Luca Boccassi <luca.boccassi@...277...>
Date: Mon, 16 Mar 2026 12:00:28 +0000
Message-ID: <CAMw=ZnTc41DYb145kQGvJYFuwSgZLK2PaESKkr3BFtG+h+K0sQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Increase TLS_CHANNEL_BUF_SIZE from
 2048 to 8192
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, 16 Mar 2026 at 11:57, Arne Schwabe <arne@...1227...> wrote:
>
> Am 15.03.26 um 19:39 schrieb luca.boccassi@...277...:
> > From: Luca Boccassi <luca.boccassi@...277...>
> >
> > When authenticating via a JWT token 2048 bytes are not enough, which
> > breaks the auth process. In my local case the token is ~2100 bytes.
> > Bump the maximum harcoded size from 2k to 8k to leave some headroom.
>
> This is a change that can break compability. The normal limit is only
> 128 bw.
>
> #define USER_PASS_LEN 128

The length is actually 4K when PKCS11 is enabled, which is the case in
most distros:

/* max length of username/password */
#ifdef ENABLE_PKCS11
#define USER_PASS_LEN 4096
#else
#define USER_PASS_LEN 128
#endif

Could you please clarify how bumping this buffer max size could break
compatibility? Thanks

> Overall things like such big data should really be implemented via
> auth-pending method or similar.

Do you have more references available for this, please? Thanks

