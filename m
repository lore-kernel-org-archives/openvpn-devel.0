MIME-Version: 1.0
In-Reply-To: <nEV9l80I3peitTd26qmQFpeoaQbEO-IR74B1gOvCLv-IfvQKjNfL9UnZq1aWr20480nGcbkSnhA-mSGEI5kG7JBMsGpNbNf2FExV3CSzRf4=@protonmail.com>
References: <nEV9l80I3peitTd26qmQFpeoaQbEO-IR74B1gOvCLv-IfvQKjNfL9UnZq1aWr20480nGcbkSnhA-mSGEI5kG7JBMsGpNbNf2FExV3CSzRf4=@protonmail.com>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 8 Aug 2018 13:00:17 -0400
Message-ID: <CAKuzo_jt8v==cr4PtNdqpVQar-4Jn3CAWKmEzZuWoxMPUvRu7g@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Clarify and expand management
 interface documentation
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
To: "Jonathan K. Bullard" <jkbullard@...2282...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

Thanks for the v2.

On Wed, Aug 8, 2018 at 7:35 AM, Jonathan K. Bullard via Openvpn-devel
<openvpn-devel@lists.sourceforge.net> wrote:
> Clarify and expand the documentation for the management interface:
>
> * Add examples of static and dynamic challenge/response sequences in
> the "COMMAND -- password and username" section.
>
> * Expand the "Challenge/Response" section with more detail.
>
> * Use "management interface client" throughout (instead of "management
> client", which was used in several places previously).
>
> * Clarify when both a username and password are needed, not just a
> username or a password.
>
> * Clarify that an exit with a fatal error for a dynamic C/R will occur
> only if "--auth-retry none" (the default) is in effect.
>
> * Fix a typo. ("posesses" =3D> "possesses").
>
> Signed-off-by: Jonathan K. Bullard <jkbullard@...277...>
> ---
> v2:
>  * Incorporate Selva Nair=E2=80=99s suggestions (thanks!).
>  * Remove incorrect quotes in Example 8.
>  * Use "base 64" throughout instead of "base64".
>
>  doc/management-notes.txt | 232 ++++++++++++++++++++++++++++++++---------=
------
>  1 file changed, 159 insertions(+), 73 deletions(-)

Looks good now.

The typo pointed out by tincanteksup is not a fault of this patch
but this may be a good time to fix it -- could be done at merge time?

On line 143 of doc/management-notes.txt after applying this patch:

managment --> management

Acked-by: selva.nair@...277...

