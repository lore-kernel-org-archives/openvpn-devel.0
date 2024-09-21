From: "MaxF (Code Review)" <gerrit@...515...>
Date: Sat, 21 Sep 2024 14:26:47 +0000
In-Reply-To: <gerrit.1677175662000.I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9@...2715...>
References: <gerrit.1677175662000.I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a2ec20f5c9eef16ab062006f5ad13d2aac5a916d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tyEK1xdiljs="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement initial
 packet reflection protection using bloom filter
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--tyEK1xdiljs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

MaxF has posted comments on this change. ( http://gerrit.openvpn.net/c/open=
vpn/+/30?usp=3Demail )

Change subject: Implement initial packet reflection protection using bloom =
filter
......................................................................


Patch Set 9: Code-Review-1

(10 comments)

Patchset:

PS9:
I havne't reviewed the whole thing yet, but I found some stuff to complain =
about


File src/openvpn/Makefile.am:

http://gerrit.openvpn.net/c/openvpn/+/30/comment/5feab99c_f33c2318 :
PS8, Line 46:     b
tabs vs spaces


File src/openvpn/bloom.h:

http://gerrit.openvpn.net/c/openvpn/+/30/comment/88db0086_921e0752 :
PS8, Line 8:  2022
Shouldn't this be 2024?


http://gerrit.openvpn.net/c/openvpn/+/30/comment/c0e46973_ad5f7ee1 :
PS8, Line 32: BLOOM_FILTER_BIT_COUNT
BITS


File src/openvpn/bloom.c:

http://gerrit.openvpn.net/c/openvpn/+/30/comment/ca1b18dc_b9ffbcbe :
PS8, Line 101: /**
             :  * Calculates the number of bytes we need for storing a bloo=
m filter of size
             :  * size. We add + 1 to avoid rounding problems and too small=
 allocation */
             : static inline
             : size_t
             : bloom_get_filter_byte_count(size_t size)
             : {
             :     static_assert(sizeof(bloom_counter_t) * 8 % BLOOM_FILTER=
_BITS_COUNT =3D=3D 0,
             :                   "bloom_counter_t must be a multiple of BLO=
OM_FILTER_BIT_COUNT");
             :
             :     return size * sizeof(bloom_counter_t)/BLOOM_FILTER_BITS_=
COUNT + 1;
             : }
I'm really confused by what size means here. This is *not* the size field i=
n the bloom filter struct, right? It's the total number of bits in the bloo=
m filter, right?


http://gerrit.openvpn.net/c/openvpn/+/30/comment/88af9dc3_bf01868e :
PS8, Line 115: static inline
             : size_t
             : bloom_get_filter_bit_offset(size_t bucket)
             : {
             :     return (bucket * BLOOM_FILTER_BITS_COUNT) % sizeof(bloom=
_counter_t);
             : }
If this is a bit offset, don't we need 8 * sizeof(bloom_counter_t) here?


http://gerrit.openvpn.net/c/openvpn/+/30/comment/f0ce5e7f_d277c415 :
PS8, Line 122: static inline
             : size_t
             : bloom_get_filter_array_index(size_t bucket)
             : {
             :     return (bucket * BLOOM_FILTER_BITS_COUNT) / sizeof(bloom=
_counter_t);
             : }
This seems wrong to me. Every bucket is 2 bits wide. The bloom_counter_t is=
 32 bits wide, or 4 bytes, so sizeof(bloom_counter_t) =3D=3D 4.

Bucket 3 is at a 6 bit offset, so it's in the first bloom_counter_t (array =
index 0). But this function gives 3 * 2 / 4 =3D=3D 1.


http://gerrit.openvpn.net/c/openvpn/+/30/comment/688a1a4a_2c63f6ac :
PS8, Line 172:
whitespace


File src/openvpn/reflect_filter.c:

http://gerrit.openvpn.net/c/openvpn/+/30/comment/e570d1bc_a93710c4 :
PS8, Line 43: static bool
            : reflect_filter_rate_l
Remove empty line


http://gerrit.openvpn.net/c/openvpn/+/30/comment/71c672e1_c93872de :
PS8, Line 116:    /* we keep the count in the key instead of in the bloom f=
ilter table as
             :      * can then keep the counter in the bloom filter itself =
small (2 bits)
...as we can then...



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/30?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9
Gerrit-Change-Number: 30
Gerrit-PatchSet: 9
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Sat, 21 Sep 2024 14:26:47 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--tyEK1xdiljs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 9:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/30?usp=3Demail">Vie=
w Change</a></p><p>10 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/30?tab=3Dcomments">Patch Set #9:</a> </p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">I havne&#39;t reviewed the whole thing yet, bu=
t I found some stuff to complain about</p></li></ul></li><li style=3D"margi=
n: 0; padding: 0;"><p>File src/openvpn/Makefile.am:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/30/comment/5feab99c_f33c2318">Patch Set #8, Line 46:</a> <code style=3D"f=
ont-family:monospace,monospace">    b</code></p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">tabs vs spaces</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/bloom.h:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/30/comment/88db0086_921e0752">Patch Set #8, Line 8:</a> <code style=
=3D"font-family:monospace,monospace"> 2022 </code></p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Shouldn&#39;t this be 2024?</p></li><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/30/comment/c0e46973_ad5=
f7ee1">Patch Set #8, Line 32:</a> <code style=3D"font-family:monospace,mono=
space">BLOOM_FILTER_BIT_COUNT</code></p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">BITS</p></li></ul></li><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/bloom.c:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/30/comment/c=
a1b18dc_b9ffbcbe">Patch Set #8, Line 101:</a> </p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">/**<br> * Calcul=
ates the number of bytes we need for storing a bloom filter of size<br> * s=
ize. We add + 1 to avoid rounding problems and too small allocation */<br>s=
tatic inline<br>size_t<br>bloom_get_filter_byte_count(size_t size)<br>{<br>=
    static_assert(sizeof(bloom_counter_t) * 8 % BLOOM_FILTER_BITS_COUNT =3D=
=3D 0,<br>                  &quot;bloom_counter_t must be a multiple of BLO=
OM_FILTER_BIT_COUNT&quot;);<br><br>    return size * sizeof(bloom_counter_t=
)/BLOOM_FILTER_BITS_COUNT + 1;<br>}<br></pre></blockquote></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">I&#39;m really confused by wh=
at size means here. This is *not* the size field in the bloom filter struct=
, right? It&#39;s the total number of bits in the bloom filter, right?</p><=
/li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/30/comment/88af9dc=
3_bf01868e">Patch Set #8, Line 115:</a> </p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">static inline<br>size_=
t<br>bloom_get_filter_bit_offset(size_t bucket)<br>{<br>    return (bucket =
* BLOOM_FILTER_BITS_COUNT) % sizeof(bloom_counter_t);<br>}<br></pre></block=
quote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">If thi=
s is a bit offset, don&#39;t we need 8 * sizeof(bloom_counter_t) here?</p><=
/li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/30/comment/f0ce5e7=
f_d277c415">Patch Set #8, Line 122:</a> </p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">static inline<br>size_=
t<br>bloom_get_filter_array_index(size_t bucket)<br>{<br>    return (bucket=
 * BLOOM_FILTER_BITS_COUNT) / sizeof(bloom_counter_t);<br>}<br></pre></bloc=
kquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">This =
seems wrong to me. Every bucket is 2 bits wide. The bloom_counter_t is 32 b=
its wide, or 4 bytes, so sizeof(bloom_counter_t) =3D=3D 4.</p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Bucket 3 is at a 6 bit offset=
, so it&#39;s in the first bloom_counter_t (array index 0). But this functi=
on gives 3 * 2 / 4 =3D=3D 1.</p></li><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/30/comment/688a1a4a_2c63f6ac">Patch Set #8, Line 172:</a> <c=
ode style=3D"font-family:monospace,monospace">    </code></p><p style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">whitespace</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/reflect_filter.c:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/30/comment/e570d1bc_a93710c4">Patch Set #8, Line 43=
:</a> </p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;"><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">static bool<br>reflect_filter_rate_l<br></pre></blockquo=
te></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Remove em=
pty line</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/30/co=
mment/71c672e1_c93872de">Patch Set #8, Line 116:</a> </p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">   /* we =
keep the count in the key instead of in the bloom filter table as<br>     *=
 can then keep the counter in the bloom filter itself small (2 bits)<br></p=
re></blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">...as we can then...</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/30?usp=3Demail">change 30</a>. To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:=
//schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/30?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a9274cab7fefce3b13c05052fb=
9a072e0bfa6b9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 30 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 21 Sep 2024 14:26:47=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--tyEK1xdiljs=--

