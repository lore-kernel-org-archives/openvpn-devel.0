MIME-Version: 1.0
In-Reply-To: <aef485c7-f619-eaac-6534-0828ab9d41f5@...2318...>
References: <20171110163946.7656-1-fkooman@...2318...>
 <63ccd0e3-491f-3fb3-e611-9b6674d3d501@...2298...>
 <aef485c7-f619-eaac-6534-0828ab9d41f5@...2318...>
From: Selva <selva.nair@...277...>
Date: Sun, 12 Nov 2017 12:21:06 -0500
Message-ID: <CAKuzo_jfJQOBhYMEyT4oiNN1xAZkvkxZm8eeDT=xcUfToaC9kQ@...278...>
Content-Type: multipart/alternative; boundary="94eb2c04422a47c61c055dcc62b8"
Subject: Re: [Openvpn-devel] [PATCH] Implement "status 4" (JSON) for
 management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Fran=C3=A7ois_Kooman?= <fkooman@...2318...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c04422a47c61c055dcc62b8
Content-Type: text/plain; charset="UTF-8"

Hi

> 3) I believe the output structure is not valid JSON with the "END"
> > string at the end.
>
> All (multiline) responses end with "END", so that's why I did that as
> well. Ideally I'd construct a JSON object that does not include newlines
> at all and just responds as:
>
> SUCCESS: { ... }
>

One of the niceties of JSON is its readability which is greatly reduced
if formatted without line breaks. Multi-line with the same
format used for management and console would be nice. Except the
former gets the extra footer line with "END".

Selva

--94eb2c04422a47c61c055dcc62b8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div><br><div class=3D"gmail_extra"><div class=3D"gmail_=
quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><span>
&gt; 3) I believe the output structure is not valid JSON with the &quot;END=
&quot;<br>
&gt; string at the end.<br>
<br>
</span>All (multiline) responses end with &quot;END&quot;, so that&#39;s wh=
y I did that as<br>
well. Ideally I&#39;d construct a JSON object that does not include newline=
s<br>
at all and just responds as:<br>
<br>
SUCCESS: { ... }<br></blockquote><div><br></div><div>One of the niceties of=
 JSON is its readability which is greatly reduced</div><div>if formatted wi=
thout line breaks. Multi-line with the same</div><div>format used for manag=
ement and console would be nice. Except the</div><div>former gets the extra=
 footer line with &quot;END&quot;.</div><div><br></div><div>Selva</div></di=
v></div></div></div>

--94eb2c04422a47c61c055dcc62b8--

