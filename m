MIME-Version: 1.0
In-Reply-To: <20180725214334.GE55859@...1296...>
References: <1516833453-18991-1-git-send-email-selva.nair@...277...>
 <1532486093-24793-1-git-send-email-selva.nair@...277...>
 <CAC+mqbndu79SZhVuL0aX3Jfar4WgPc_JkUdCv1=8s-Lj7vCqrw@...278...>
 <20180725214334.GE55859@...1296...>
From: Joe Bell <joeaintexas@...277...>
Date: Wed, 25 Jul 2018 17:33:00 -0500
Message-ID: <CAC+mqbnubSpYtGEp2WeLye3b8B1G8TYBnnDP5yBbd4NqpTV1_A@...278...>
Content-Type: multipart/alternative; boundary="0000000000000ff96e0571da76eb"
Subject: Re: [Openvpn-devel] [PATCH v3] Parse static challenge response in
 auth-pam plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel@lists.sourceforge.net

--0000000000000ff96e0571da76eb
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 25, 2018 at 4:43 PM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Wed, Jul 25, 2018 at 04:31:05PM -0500, Joe Bell wrote:
> > I don't know if it is appropriate to reply to this post in this manner,
>
> It is and it helps :-)
>
> We want test reports, as in "I am using this, because it is a useful
> feature for me, and it works fine!" - not as strong as a full code
> review, but an indication that something is beneficial at least.
>

Terrific.  Indeed, I am using this now, and quite successfully in a staging
environment.


>
> [..]
> > If there is anything I can do to provide a list of testcases, write-up on
> > its configuration and usage, etc., in aide of getting the patch merged
> and
> > released, please let me know.
>
> If you could find a few spare weeks for me, that would help quite a bit :-)
>
> Jokes aside, a bit of writeup how this looks in the client config, how
> the client prompts will then look, and how you configure the server would
> be nice - just here on the list, so google can find it.
>
>
I will do a full writeup, but the magic comes from

plugin /usr/lib/openvpn/plugins/openvpn-plugin-auth-pam.so "openvpn login:
USERNAME Password: PASSWORD Verification OTP"

in the OpenVPN server.conf, as well as:

auth required /lib/security/pam_google_authenticator.so
secret=/etc/openvpn/google-authenticator/${USER} user=gauth
auth required pam_ldap.so

for the contents of /etc/pam.d/openvpn. (Note that I'm using LDAP for
username/password, this should be replaced by the appropriate PAM module
for other types.)

Then, on the client configuration (.ovpn):

auth-user-pass
static-challenge "Enter Google Authenticator Token" 1

Now obviously there are a lot of details i've left out (setting up Google
Authenticator, etc.) but once I compiled OpenVPN with the base64 patch and
the plugin patch, it was smiles all around.  I will work to put together a
full write-up of zero to sixty with screenshots, etc.

I've been delighted to cobble this together with my previous knowledge of
OpenVPN configurations, finding Selva's patches, and pointers on how to
pull this all together, but without a doubt it would have been delightful
to have it out-of-the-box.  Thanks for the feedback and encouragement to
push for this.

Joe

--0000000000000ff96e0571da76eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On W=
ed, Jul 25, 2018 at 4:43 PM, Gert Doering <span dir=3D"ltr">&lt;<a href=3D"=
mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span> wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<span class=3D"gmail-"><br>
On Wed, Jul 25, 2018 at 04:31:05PM -0500, Joe Bell wrote:<br>
&gt; I don&#39;t know if it is appropriate to reply to this post in this ma=
nner, <br>
<br>
</span>It is and it helps :-)<br>
<br>
We want test reports, as in &quot;I am using this, because it is a useful<b=
r>
feature for me, and it works fine!&quot; - not as strong as a full code<br>
review, but an indication that something is beneficial at least.<br></block=
quote><div><br></div><div>Terrific.=C2=A0 Indeed, I am using this now, and =
quite successfully in a staging environment.</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<br>
[..]<br>
<span class=3D"gmail-">&gt; If there is anything I can do to provide a list=
 of testcases, write-up on<br>
&gt; its configuration and usage, etc., in aide of getting the patch merged=
 and<br>
&gt; released, please let me know.<br>
<br>
</span>If you could find a few spare weeks for me, that would help quite a =
bit :-)<br>
<br>
Jokes aside, a bit of writeup how this looks in the client config, how<br>
the client prompts will then look, and how you configure the server would<b=
r>
be nice - just here on the list, so google can find it.<br>
<br></blockquote><div><br></div><div>I will do a full writeup, but the magi=
c comes from</div><div><br></div><div><font face=3D"monospace, monospace">p=
lugin /usr/lib/openvpn/plugins/openvpn-plugin-auth-pam.so &quot;openvpn log=
in: USERNAME Password: PASSWORD Verification OTP&quot;</font></div><div><br=
></div><div>in the OpenVPN server.conf, as well as:</div><div><br></div><di=
v><div><font face=3D"monospace, monospace">auth required /lib/security/pam_=
google_authenticator.so secret=3D/etc/openvpn/google-authenticator/${USER} =
user=3Dgauth</font></div><div><font face=3D"monospace, monospace">auth requ=
ired pam_ldap.so</font></div></div><div><br></div><div>for the contents of=
=C2=A0<span style=3D"font-family:monospace,monospace;font-size:small;backgr=
ound-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-c=
olor:initial;float:none;display:inline">/etc/pam.d/openvpn</span><span styl=
e=3D"font-size:small;background-color:rgb(255,255,255);text-decoration-styl=
e:initial;text-decoration-color:initial;float:none;display:inline"><font fa=
ce=3D"arial, helvetica, sans-serif">. (Note that I&#39;m using LDAP for use=
rname/password, this should be replaced by the appropriate PAM module for o=
ther types.)</font></span></div><div><span style=3D"font-size:small;backgro=
und-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-co=
lor:initial;float:none;display:inline"><font face=3D"arial, helvetica, sans=
-serif"><br></font></span></div><div><span style=3D"font-size:small;backgro=
und-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-co=
lor:initial;float:none;display:inline"><font face=3D"arial, helvetica, sans=
-serif">Then, on the client configuration (.ovpn):</font></span></div><div>=
<span style=3D"font-size:small;background-color:rgb(255,255,255);text-decor=
ation-style:initial;text-decoration-color:initial;float:none;display:inline=
"><font face=3D"arial, helvetica, sans-serif"><br></font></span></div><div>=
<span style=3D"background-color:rgb(255,255,255);text-decoration-style:init=
ial;text-decoration-color:initial;float:none;display:inline"><font face=3D"=
monospace, monospace"><div style=3D"">auth-user-pass</div><div style=3D"">s=
tatic-challenge &quot;Enter Google Authenticator Token&quot; 1</div></font>=
</span></div><div><span style=3D"font-size:small;background-color:rgb(255,2=
55,255);text-decoration-style:initial;text-decoration-color:initial;float:n=
one;display:inline"><font face=3D"arial, helvetica, sans-serif"><br></font>=
</span></div><div><span style=3D"font-size:small;background-color:rgb(255,2=
55,255);text-decoration-style:initial;text-decoration-color:initial;float:n=
one;display:inline"><font face=3D"arial, helvetica, sans-serif">Now obvious=
ly there are a lot of details i&#39;ve left out (setting up Google Authenti=
cator, etc.) but once I compiled OpenVPN with the base64 patch and the plug=
in patch, it was smiles all around.=C2=A0 I will work to put together a ful=
l write-up of zero to sixty with screenshots, etc.</font></span></div><div>=
<span style=3D"font-size:small;background-color:rgb(255,255,255);text-decor=
ation-style:initial;text-decoration-color:initial;float:none;display:inline=
"><font face=3D"arial, helvetica, sans-serif"><br></font></span></div><div>=
<span style=3D"font-size:small;background-color:rgb(255,255,255);text-decor=
ation-style:initial;text-decoration-color:initial;float:none;display:inline=
"><font face=3D"arial, helvetica, sans-serif">I&#39;ve been delighted to co=
bble this together with my previous knowledge of OpenVPN configurations, fi=
nding Selva&#39;s patches, and pointers on how to pull this all together, b=
ut without a doubt it would have been delightful to have it out-of-the-box.=
=C2=A0 Thanks for the feedback and encouragement to push for this.</font></=
span></div><div><span style=3D"font-size:small;background-color:rgb(255,255=
,255);text-decoration-style:initial;text-decoration-color:initial;float:non=
e;display:inline"><font face=3D"arial, helvetica, sans-serif"><br></font></=
span></div><div><span style=3D"font-size:small;background-color:rgb(255,255=
,255);text-decoration-style:initial;text-decoration-color:initial;float:non=
e;display:inline"><font face=3D"arial, helvetica, sans-serif">Joe</font></s=
pan></div><div><span style=3D"font-size:small;background-color:rgb(255,255,=
255);text-decoration-style:initial;text-decoration-color:initial;float:none=
;display:inline"><font face=3D"arial, helvetica, sans-serif"><br></font></s=
pan></div></div></div></div>

--0000000000000ff96e0571da76eb--

