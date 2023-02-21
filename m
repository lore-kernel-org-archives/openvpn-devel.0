Content-Type: multipart/alternative;
 boundary="------------R3kT9Y4hcQJZpGaSBv1PETFe"
Message-ID: <675b0531-20d2-3141-a82c-f495222298e6@...68...>
Date: Tue, 21 Feb 2023 08:37:50 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <Y+4mj61K0/yRFUXH@...2685...>
 <CAEsd45QdepRa+D+GdeS_aHtPkDNxPEFX3aVArstQRN1BM8UMSA@...278...>
 <Y+5tRm1FpCdhARk4@...1296...>
From: Matthias Andree <matthias.andree@...68...>
In-Reply-To: <Y+5tRm1FpCdhARk4@...1296...>
Subject: Re: [Openvpn-devel] OpenVPN 2.5.9 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------R3kT9Y4hcQJZpGaSBv1PETFe
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Am 16.02.23 um 18:52 schrieb Gert Doering:
> Hi,
>
> On Thu, Feb 16, 2023 at 08:48:26AM -0500, Jonathan K. Bullard wrote:
>> On Thu, Feb 16, 2023 at 7:51 AM Frank Lichtenheld<frank@...2641...>  wro=
te:
>>> The OpenVPN community project team is proud to release OpenVPN 2.5.9. T=
his is
>>> a small bugfix release.
>> Was this sent a bit early? There is no 2.5.9 tag at
>> https://github.com/OpenVPN/openvpn/tags.
> One day I will learn that it's "git push" *and* "git push --tags".
>
> So the repo was updated, but the tag was missing.  Sorry for that.


I've come to like git push --follow-tags: (quoting the 2.39.2 manpage)
which is a two-in-one for typical release pushes:

> --follow-tags
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Push all the=
 refs that would be pushed without this option,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and also pus=
h annotated tags in refs/tags that are missing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from the rem=
ote but are pointing at commit-ish that are
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reachable fr=
om the refs being pushed. This can also be
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 specified wi=
th configuration variable push.followTags. For
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 more informa=
tion, see push.followTags in git-config(1).

This assumes that tags are annotated, but since you've signed it, it's
also annotated.=C2=A0 Note there is a corresponding configuration option, t=
oo.

HTH
Matthias


> gert
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--------------R3kT9Y4hcQJZpGaSBv1PETFe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">Am 16.02.23 um 18:52 schrieb Gert
      Doering:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:Y+5tRm1FpCdhARk4@...1296...">
      <pre class=3D"moz-quote-pre" wrap=3D"">Hi,

On Thu, Feb 16, 2023 at 08:48:26AM -0500, Jonathan K. Bullard wrote:
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">On Thu, Feb 16, 2023 at 7:51=
 AM Frank Lichtenheld <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:fra=
nk@...2641...">&lt;frank@...2641...&gt;</a> wrote:
</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">
The OpenVPN community project team is proud to release OpenVPN 2.5.9. This =
is
a small bugfix release.
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
Was this sent a bit early? There is no 2.5.9 tag at
<a class=3D"moz-txt-link-freetext" href=3D"https://github.com/OpenVPN/openv=
pn/tags">https://github.com/OpenVPN/openvpn/tags</a>.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
One day I will learn that it's "git push" *and* "git push --tags".

So the repo was updated, but the tag was missing.  Sorry for that.
</pre>
    </blockquote>
    <p><br>
      I've come to like git push --follow-tags: (quoting the 2.39.2
      manpage) which is a two-in-one for typical release pushes:<br>
      <br>
    </p>
    <blockquote type=3D"cite" style=3D"font-style: italic; color: #006600;"=
>--follow-tags
      <br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Push all=
 the refs that would be pushed without this
      option,
      <br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and also=
 push annotated tags in refs/tags that are
      missing
      <br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from the=
 remote but are pointing at commit-ish that are
      <br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reachabl=
e from the refs being pushed. This can also be
      <br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 specifie=
d with configuration variable push.followTags.
      For
      <br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 more inf=
ormation, see push.followTags in git-config(1).
      <br>
    </blockquote>
    <br>
    This assumes that tags are annotated, but since you've signed it,
    it's also annotated.=C2=A0 Note there is a corresponding configuration
    option, too.
    <br>
    <br>
    HTH
    <br>
    Matthias<br>
    <p><br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:Y+5tRm1FpCdhARk4@...1296...">
      <pre class=3D"moz-quote-pre" wrap=3D"">
gert

</pre>
      <br>
      <fieldset class=3D"moz-mime-attachment-header"></fieldset>
      <br>
      <fieldset class=3D"moz-mime-attachment-header"></fieldset>
      <pre class=3D"moz-quote-pre" wrap=3D"">______________________________=
_________________
Openvpn-devel mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Openvpn-devel@...1466...=
urceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.sourceforge.net/li=
sts/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/op=
envpn-devel</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------R3kT9Y4hcQJZpGaSBv1PETFe--

