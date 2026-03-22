MIME-Version: 1.0
References: <20260316224531.315912-1-luca.boccassi@...277...>
 <CAKuzo_gRotwfVONQSn-yj1otvUNocAeUZqX8YjkRhP_L9jfb7A@...278...>
In-Reply-To: <CAKuzo_gRotwfVONQSn-yj1otvUNocAeUZqX8YjkRhP_L9jfb7A@...278...>
From: Luca Boccassi <luca.boccassi@...277...>
Date: Sun, 22 Mar 2026 01:48:51 +0000
Message-ID: <CAMw=ZnSrHOd-F0PZVKd1HW_a-E_8x=CF7rZ3VnV7i59JiY_Y3w@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix password usage with ENABLE_PKCS11
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, 17 Mar 2026 at 00:07, Selva Nair <selva.nair@...277...> wrote:
>
> On Mon, Mar 16, 2026 at 6:48=E2=80=AFPM <luca.boccassi@...277...> wrote:
> >
> > From: Luca Boccassi <luca.boccassi@...277...>
> >
> > With ENABLE_PKCS11 USER_PASS_LEN is set to 4096 bytes.
> >
> > But if a user specifies a large password, as allowed by the limit,
> > there are two places in the client that fail to handle it:
> >
>
> The misunderstanding here is the assumption that ENABLE_PKCS11 builds
> were supposed to support username/password > 128. They do not -- the
> 4096 number was added for some local usage (like private key passwords
> and PINs, or some misunderstanding, I guess), not meant to apply to
> password data to be passed from client to server or other way -- that
> never worked.
>
> As you have already seen, there are existing limits in multiple places
> that make larger than 128 byte username/password not to work reliably
> (or possibly 255). Management and option parsing always had 255 byte
> limitations, the 2048 tls-channel-buffer limits password+username to
> about 1600 bytes or thereabout.
>
> I'm not saying we should not support larger passwords. In fact I do
> feel that allowing the management interface to pass longer passwords
> could be a useful goal if it can be done with minimal disruption (say
> keep username + password fit in current control TLS buffers). But even
> there, the "right" way to do it may be to use multi-line base64 as we
> already do in the daemon -> client direction. If anyone has
> "passwords" longer than 1k bytes or so, they are doing something wrong
> and fixing it in the wrong place. "I have no access to the broken
> piece of software, so let us fix it here" is not going to be
> acceptable.

Thanks for the suggestion, I have sent a new version that only adds
the multi-line base64 protocol as recommended. Verified with a custom
build of NetworkManager-openvpn that uses this new management
interface.

