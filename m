From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sun, 29 Dec 2024 03:09:05 +0000
In-Reply-To: <gerrit.1731290343000.Id7d6a576ca8c9560cb2dfae82fc62175820e9b80@...2715...>
References: <gerrit.1731290343000.Id7d6a576ca8c9560cb2dfae82fc62175820e9b80@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., max@...2606...
Message-ID: <87f72477ed56cf4de89e7324706e45990765a7a3-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7wmKIlcr76M="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Implement methods to
 generate and manage OpenVPN Epoch keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: MaxF <max@...2606...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7wmKIlcr76M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/804?usp=3Demail )

Change subject: Implement methods to generate and manage OpenVPN Epoch keys
......................................................................


Patch Set 9:

(23 comments)

File src/openvpn/crypto.h:

http://gerrit.openvpn.net/c/openvpn/+/804/comment/4cf4ae43_56da8da9 :
PS9, Line 175: /** the epoch of the key is if it was generated as epoch dat=
a key material */
> I think you mean: The epoch of the key, if it was generated as epoch data=
 key material. [=E2=80=A6]
I will clarify that this only meaningful if key parameters are used in epoc=
h data and it is not meaningful otherwise.


http://gerrit.openvpn.net/c/openvpn/+/804/comment/788a09ea_7023fafa :
PS9, Line 223: is
> this?
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/804/comment/3d1e7540_b7a53f6a :
PS9, Line 307: This limit for AEAD cipher
> The limit for AEAD ciphers?
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/804/comment/1dead943_a6393dd1 :
PS9, Line 315: key
> keys
yes but also the comment is wrong as epoch_data_keys_future only stores rec=
eive keys.


http://gerrit.openvpn.net/c/openvpn/+/804/comment/78aa125b_37d2d67c :
PS9, Line 316: to switch also sending key
> to also switch the sending key?
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/804/comment/f57d4cd6_30ec7906 :
PS9, Line 324: switch
> switched?
yes, and also before instead of bevor.


http://gerrit.openvpn.net/c/openvpn/+/804/comment/be5e1ecc_1af62691 :
PS9, Line 524: @param epoch Epoch read from packet or 0 when epoch is not u=
sed.
> That's not an argument of the function.
yes that got into a commit too early. I moved it to the commit that actuall=
y adds the epoch parameter.


File src/openvpn/crypto_epoch.h:

http://gerrit.openvpn.net/c/openvpn/+/804/comment/87827b4b_e2c66cc6 :
PS9, Line 72: * @param epoch_key     Epoch key to be used
            :  * @param key          Destination for the generated data key
> wrong order compared to the function.
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/804/comment/3e654f8c_e8b2f61e :
PS9, Line 91: using
> uses
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/804/comment/0a1c083e_f7fbf9ba :
PS9, Line 96: a
> for the receive key?
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/804/comment/f2c845b2_b82d132e :
PS9, Line 103: send_epoch_keyt
> send_epoch_key
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/804/comment/2ef5767a_589a85d0 :
PS9, Line 118: * @param e1_send    The E1 send epoch key derived by TLS-EKM
             :  * @param e1_recv    The E1 receive epoch key derived by TLS=
-EKM
> incomplete parameters
Acknowledged


File src/openvpn/crypto_epoch.c:

http://gerrit.openvpn.net/c/openvpn/+/804/comment/37c7c0ca_5ba66eff :
PS9, Line 136: 11
> We could use strlen() here.
I will be using sizeof(array) - 1 as strlen doesn't really like operating o=
n a uint8_t array.


http://gerrit.openvpn.net/c/openvpn/+/804/comment/b83b22ac_c3dd00bb :
PS9, Line 157: 8
> strlen?
same as above


http://gerrit.openvpn.net/c/openvpn/+/804/comment/ae88362e_fa765dab :
PS9, Line 163: 7
> strlen?
same as above


http://gerrit.openvpn.net/c/openvpn/+/804/comment/4b15f462_6189d29b :
PS9, Line 210: uint16_t current_epoch_recv =3D co->key_ctx_bi.decrypt.epoch;
> The variable name makes this look like it should be co->epoch_key_recv.ep=
och. [=E2=80=A6]
I reworked the comment and the function doxygen to hopefully make it a bit =
better to understand.


http://gerrit.openvpn.net/c/openvpn/+/804/comment/85168ea8_12a0a758 :
PS9, Line 423: is
> in?
not sure how I managed to mangle this when I copy&pasted it.


File src/openvpn/packet_id.h:

http://gerrit.openvpn.net/c/openvpn/+/804/comment/929b34fb_60e60e0a :
PS9, Line 214:  */
> Incomplete
Acknowledged


File src/openvpn/packet_id.c:

http://gerrit.openvpn.net/c/openvpn/+/804/comment/129a630b_4118bf6c :
PS9, Line 81: packet_id_init_recv(struct packet_id_rec *rec, int seq_backtr=
ack, int time_backtrack, const char *name, int unit)
> You could make this a static function.
Acknowledged


File tests/unit_tests/openvpn/test_crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/804/comment/b63adfb5_696e6519 :
PS9, Line 728: is uses
> uses
Done


http://gerrit.openvpn.net/c/openvpn/+/804/comment/aa4ca31d_556d7a6b :
PS9, Line 830: 1-5
> 2-6
Done


http://gerrit.openvpn.net/c/openvpn/+/804/comment/cb188983_ad366b2c :
PS9, Line 835:     assert_int_equal(epoch_lookup_decrypt_key(co, 1)->epoch,=
 1);
> Could we make sure that it really is the retiring key by comparing it wit=
h &co->epoch_retiring_data_ [=E2=80=A6]
good idea.


http://gerrit.openvpn.net/c/openvpn/+/804/comment/eca5ecc7_126d252a :
PS9, Line 899:     assert_null(epoch_lookup_decrypt_key(co, UINT16_MAX - 32=
));
> This hard-codes the assumption that this function is called with a state =
that has num_future_keys =3D=3D [=E2=80=A6]
I think for a unit test hardcoding this is fine. I think we want to rather =
hardcode it here rather then to rely on the internal state of co being corr=
ect for the unit test.

I will add an assert that the num_future_keys is 32 and then use num_future=
_keys as you suggested.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/804?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id7d6a576ca8c9560cb2dfae82fc62175820e9b80
Gerrit-Change-Number: 804
Gerrit-PatchSet: 9
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Sun, 29 Dec 2024 03:09:05 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: MaxF <max@...2606...>
Gerrit-MessageType: comment

--7wmKIlcr76M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/804?usp=3Demail">View C=
hange</a></p><p>23 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto.h:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/804/comment/4cf4ae43_56da8da9">Patch Set #9, Line 175:</a=
> <code style=3D"font-family:monospace,monospace">/** the epoch of the key =
is if it was generated as epoch data key material */</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
I think you mean: The epoch of the key, if it was generated as epoch data k=
ey material. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">I will clarify that this only meaningful if key pa=
rameters are used in epoch data and it is not meaningful otherwise.</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/804/comment/788a09ea_=
7023fafa">Patch Set #9, Line 223:</a> <code style=3D"font-family:monospace,=
monospace">is</code></p><p><blockquote style=3D"border-left: 1px solid #aaa=
; margin: 10px 0; padding: 0 10px;">this?</blockquote></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/804/comment/3d1e7540_b7a53f6a">Pa=
tch Set #9, Line 307:</a> <code style=3D"font-family:monospace,monospace">T=
his limit for AEAD cipher</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">The limit for AEAD ciphers?=
</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Acknowledged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
804/comment/1dead943_a6393dd1">Patch Set #9, Line 315:</a> <code style=3D"f=
ont-family:monospace,monospace">key</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">keys</blockquote>=
</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">yes but also=
 the comment is wrong as epoch_data_keys_future only stores receive keys.</=
p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/804/comment/78a=
a125b_37d2d67c">Patch Set #9, Line 316:</a> <code style=3D"font-family:mono=
space,monospace">to switch also sending key</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">to also =
switch the sending key?</blockquote></p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">Acknowledged</p></li><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/804/comment/f57d4cd6_30ec7906">Patch Set #9, Line 32=
4:</a> <code style=3D"font-family:monospace,monospace">switch</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">switched?</blockquote></p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">yes, and also before instead of bevor.</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/804/comment/be5e1ecc_1af62691">=
Patch Set #9, Line 524:</a> <code style=3D"font-family:monospace,monospace"=
>@param epoch Epoch read from packet or 0 when epoch is not used.</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">That&#39;s not an argument of the function.</blockquote></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">yes that got into =
a commit too early. I moved it to the commit that actually adds the epoch p=
arameter.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File sr=
c/openvpn/crypto_epoch.h:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/804/comment/87827b4b_e2c=
66cc6">Patch Set #9, Line 72:</a> </p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;"><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">* @param epoch_key     Epoch=
 key to be used<br> * @param key          Destination for the generated dat=
a key<br></pre></blockquote></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">wrong order compared to the fun=
ction.</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Acknowledged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/804/comment/3e654f8c_e8b2f61e">Patch Set #9, Line 91:</a> <code style=
=3D"font-family:monospace,monospace">using</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">uses</bl=
ockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Ack=
nowledged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/804/=
comment/0a1c083e_f7fbf9ba">Patch Set #9, Line 96:</a> <code style=3D"font-f=
amily:monospace,monospace">a</code></p><p><blockquote style=3D"border-left:=
 1px solid #aaa; margin: 10px 0; padding: 0 10px;">for the receive key?</bl=
ockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Ack=
nowledged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/804/=
comment/f2c845b2_b82d132e">Patch Set #9, Line 103:</a> <code style=3D"font-=
family:monospace,monospace">send_epoch_keyt</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">send_epo=
ch_key</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Acknowledged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/804/comment/2ef5767a_589a85d0">Patch Set #9, Line 118:</a> </p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;"><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">* @param e1_send    The E1 send epoch key derived by TLS-EKM<br> * @para=
m e1_recv    The E1 receive epoch key derived by TLS-EKM<br></pre></blockqu=
ote></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">incomplete parameters</blockquote></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></ul></li><l=
i style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto_epoch.c:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/804/comment/37c7c0ca_5ba66eff">Patch Set #9, Line 136:=
</a> <code style=3D"font-family:monospace,monospace">11</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">We could use strlen() here.</blockquote></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">I will be using sizeof(array) - 1 as strlen =
doesn&#39;t really like operating on a uint8_t array.</p></li><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/804/comment/b83b22ac_c3dd00bb">Pa=
tch Set #9, Line 157:</a> <code style=3D"font-family:monospace,monospace">8=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">strlen?</blockquote></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">same as above</p></li><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/804/comment/ae88362e_fa765dab">Patch Set #9,=
 Line 163:</a> <code style=3D"font-family:monospace,monospace">7</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">strlen?</blockquote></p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">same as above</p></li><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/804/comment/4b15f462_6189d29b">Patch Set #9, Line 210:<=
/a> <code style=3D"font-family:monospace,monospace">uint16_t current_epoch_=
recv =3D co-&gt;key_ctx_bi.decrypt.epoch;</code></p><p><blockquote style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">The variabl=
e name makes this look like it should be co-&gt;epoch_key_recv.epoch. [=E2=
=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">I reworked the comment and the function doxygen to hopefully make i=
t a bit better to understand.</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/804/comment/85168ea8_12a0a758">Patch Set #9, Line 423:</a> =
<code style=3D"font-family:monospace,monospace">is</code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">in=
?</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">not sure how I managed to mangle this when I copy&amp;pasted it.</p></li>=
</ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/packet_i=
d.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/804/comment/929b34fb_60e60e0a">Patch Set #9, =
Line 214:</a> <code style=3D"font-family:monospace,monospace"> */</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">Incomplete</blockquote></p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">Acknowledged</p></li></ul></li><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/packet_id.c:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
804/comment/129a630b_4118bf6c">Patch Set #9, Line 81:</a> <code style=3D"fo=
nt-family:monospace,monospace">packet_id_init_recv(struct packet_id_rec *re=
c, int seq_backtrack, int time_backtrack, const char *name, int unit)</code=
></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">You could make this a static function.</blockquote></p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></l=
i></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/o=
penvpn/test_crypto.c:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/804/comment/b63adfb5_696e651=
9">Patch Set #9, Line 728:</a> <code style=3D"font-family:monospace,monospa=
ce">is uses</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">uses</blockquote></p><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/804/comment/aa4ca31d_556d7a6b">Patch Set #9, =
Line 830:</a> <code style=3D"font-family:monospace,monospace">1-5</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">2-6</blockquote></p><p style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/804/comment/cb188983_ad366b2c">Patch Set #9, Line 835:</a> <code st=
yle=3D"font-family:monospace,monospace">    assert_int_equal(epoch_lookup_d=
ecrypt_key(co, 1)-&gt;epoch, 1);</code></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Could we make sure t=
hat it really is the retiring key by comparing it with &amp;co-&gt;epoch_re=
tiring_data_ [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">good idea.</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/804/comment/eca5ecc7_126d252a">Patch Set #9, Line 899=
:</a> <code style=3D"font-family:monospace,monospace">    assert_null(epoch=
_lookup_decrypt_key(co, UINT16_MAX - 32));</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This har=
d-codes the assumption that this function is called with a state that has n=
um_future_keys =3D=3D [=E2=80=A6]</blockquote></p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">I think for a unit test hardcoding this i=
s fine. I think we want to rather hardcode it here rather then to rely on t=
he internal state of co being correct for the unit test.</p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">I will add an assert that the n=
um_future_keys is 32 and then use num_future_keys as you suggested.</p></li=
></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/804?usp=3Demail">change 804</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/804?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id7d6a576ca8c9560cb2dfae82fc=
62175820e9b80 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 804 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 29 Dec 2024 03:09:05=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: MaxF &lt;max@...2606...&g=
t; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--7wmKIlcr76M=--

