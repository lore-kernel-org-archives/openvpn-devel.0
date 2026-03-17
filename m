MIME-Version: 1.0
References: <20260316224531.315912-1-luca.boccassi@...277...>
In-Reply-To: <20260316224531.315912-1-luca.boccassi@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 16 Mar 2026 20:07:38 -0400
Message-ID: <CAKuzo_gRotwfVONQSn-yj1otvUNocAeUZqX8YjkRhP_L9jfb7A@...278...>
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
To: luca.boccassi@...277...
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Mar 16, 2026 at 6:48=E2=80=AFPM <luca.boccassi@...277...> wrote:
>
> From: Luca Boccassi <luca.boccassi@...277...>
>
> With ENABLE_PKCS11 USER_PASS_LEN is set to 4096 bytes.
>
> But if a user specifies a large password, as allowed by the limit,
> there are two places in the client that fail to handle it:
>

The misunderstanding here is the assumption that ENABLE_PKCS11 builds
were supposed to support username/password > 128. They do not -- the
4096 number was added for some local usage (like private key passwords
and PINs, or some misunderstanding, I guess), not meant to apply to
password data to be passed from client to server or other way -- that
never worked.

As you have already seen, there are existing limits in multiple places
that make larger than 128 byte username/password not to work reliably
(or possibly 255). Management and option parsing always had 255 byte
limitations, the 2048 tls-channel-buffer limits password+username to
about 1600 bytes or thereabout.

I'm not saying we should not support larger passwords. In fact I do
feel that allowing the management interface to pass longer passwords
could be a useful goal if it can be done with minimal disruption (say
keep username + password fit in current control TLS buffers). But even
there, the "right" way to do it may be to use multi-line base64 as we
already do in the daemon -> client direction. If anyone has
"passwords" longer than 1k bytes or so, they are doing something wrong
and fixing it in the wrong place. "I have no access to the broken
piece of software, so let us fix it here" is not going to be
acceptable.

In any case, this has to be done carefully. There are a number of
implicit "protocol" changes in your patch:

(i) option parsing size -- are we going to define a new version of
config files that support longer lines? Looks like a wrong solution.
(ii) management interface -- do we support this only for UI
client-versions > x? How would the UI client know whether the daemon
will accept long lines?
(iii) control channel --- how to ensure backward compatibility?

I do not see your patches addressing any of these questions. Hence the
pushback. As Arne suggested, consider applying it locally for personal
use if it works in your case.

Selva

PS. This is not the first time this issue has come up -- search
openvpn devel list archives for past discussions. Here are some:

https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16674.h=
tml
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12535.h=
tml



Selva

