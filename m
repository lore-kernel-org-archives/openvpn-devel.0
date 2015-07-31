Message-ID: <55BAC85D.1050703@...1147...>
Date: Fri, 31 Jul 2015 02:59:09 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <COL128-W360F356FA6F45FADFFC4D6CA810@...512...>,
	<55B1FF56.4000209@...1147...>
	<COL128-W59456CBB4B786DDF3AECEECA800@...512...>,
	<55B56347.7010304@...1147...>
	<COL128-W78E15F40935FC606B745D7CA8E0@...512...>
In-Reply-To: <COL128-W78E15F40935FC606B745D7CA8E0@...512...>
Content-Type: multipart/alternative;
	boundary="------------040106020507070208040407"
Subject: Re: [Openvpn-devel] Does Openvpn really support cryptodev hardware
 accelerators
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: li yuqian <liyuqian08@...2047...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------040106020507070208040407
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 27/07/15 03:28, li yuqian wrote:
> Hi Jan,
>
> Thanks for your replay :)
>
> >>ah OK; I've grabbed a copy, built and installed it on 2 servers and 
> ran some test: I get similar figures for 'openssl speed' but those 
> numbers are artificial, i.e. they do not reflect true performance of 
> the system. According to the 
> sitehttp://cryptodev-linux.org/index.htmlI should be getting some 
> improvement but not *that* much.
>
> i think the cryptodev got much improved with enabled it, take a look 
> for following what i got test data
> -------------
> without cryptodev
> -------------
> The 'numbers' are in 1000s of bytes per second processed.
> type             16 bytes     64 bytes    256 bytes 1024 bytes   8192 
> bytes
> aes-128-cbc     158525.06k   214128.67k   242916.10k 250279.55k   
> 253359.45k
> -------------
> with cryptodev
> -------------
> The 'numbers' are in 1000s of bytes per second processed.
> type             16 bytes     64 bytes    256 bytes 1024 bytes   8192 
> bytes
> aes-128-cbc      45084.53k   191286.30k   656871.75k  3228385.28k 
> 18282905.60k
> --------------
> compare the 8192 bytes per second processed, with cryptodev up to 
> 18282905.60k, without is only 253359.45k, this is very good improved. 
> don't look at that times of openssl speed -evp aes-128-cbc
>
>
as I wrote in another mail on this list, it's not openvpn but the 
'openssl speed' command which fails here:

Try running this openssl command on your box:

date ; cat bigfile | openssl enc -e -aes-256-cbc -bufsize 8192 -pass 
pass:testing123 >  /dev/null ; date

where 'bigfile' is some large file of > 2 GB in size.
Then rerun it using

date ; cat bigfile | openssl enc -engine cryptodev -e -aes-256-cbc 
-bufsize 8192 -pass pass:testing123 >  /dev/null ; date

and compare the results of the dates of 'before' and 'after'. On my 
hardware I takes ~ 10 seconds to encrypt a 3.3 GB file , with zero 
difference whether I use cryptodev or not, whereas 'openssl speed' 
reports a 100+ % improvement:

with cryptodev module loaded:
    aes-256-cbc     286337.65k  1048423.31k  4589489.60k 19596646.40k 
141238272.00k

without cryptodev:
    aes-256-cbc     465276.57k   487043.33k   493990.87k 493776.90k   
495720.11k


so, apart from the fact that openvpn's speed limitations are not 
determined solely by encryption/decryption, this does prove to me that 
the cryptodev device offers little if no performance improvement.

hope this clears things up,

JJK


--------------040106020507070208040407
X-MIME-Autoconverted: from 8bit to quoted-printable by
	outgoing1-ams.mf.surf.net id t6V0xLIM001916
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Type=
">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">Hi,<br>
      <br>
      On 27/07/15 03:28, li yuqian wrote:<br>
    </div>
    <blockquote cite=3D"mid:COL128-W78E15F40935FC606B745D7CA8E0@...512..."
      type=3D"cite">
      <style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 12pt;
font-family:Calibri
}
--></style>
      <div dir=3D"ltr">Hi Jan,
        <div><br>
        </div>
        <div>Thanks for your replay :)</div>
        <div><br>
        </div>
        <div>&gt;&gt;<span style=3D"font-size: 12pt;">ah OK; I've grabbed
            a copy, built and installed it on 2 servers and ran some
            test: I get similar figures for 'openssl speed' but those
            numbers are artificial, i.e. they do not reflect true
            performance of the system. According to the site</span><span
            style=3D"font-size: 12pt;">=C2=A0</span><a moz-do-not-send=3D"t=
rue"
            class=3D"ecxmoz-txt-link-freetext"
            href=3D"http://cryptodev-linux.org/index.html" target=3D"_blank"
            style=3D"font-size: 12pt;">http://cryptodev-linux.org/index.htm=
l</a><span
            style=3D"font-size: 12pt;">=C2=A0</span><span style=3D"font-siz=
e:
            12pt;">I should be getting some improvement but not *that*
            much.</span></div>
        <div><span style=3D"font-size: 12pt;"><br>
          </span></div>
        <div><span style=3D"font-size: 12pt;">i think the cryptodev got
            much improved with=C2=A0</span>enabled<span style=3D"font-size:
            12pt;">=C2=A0it, take a look for following what i got test data=
</span></div>
        <div><span style=3D"font-size: 12pt;">-------------</span></div>
        <div><span style=3D"font-size: 12pt;">without cryptodev</span></div>
        <div><span style=3D"font-size: 12pt;">-------------</span></div>
        <div>
          <div>The 'numbers' are in 1000s of bytes per second processed.</d=
iv>
          <div>type =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 16 bytes =C2=
=A0 =C2=A0 64 bytes =C2=A0 =C2=A0256 bytes =C2=A0
            1024 bytes =C2=A0 8192 bytes</div>
          <div>aes-128-cbc =C2=A0 =C2=A0 158525.06k =C2=A0 214128.67k =C2=
=A0 242916.10k =C2=A0
            250279.55k =C2=A0 253359.45k</div>
        </div>
        <div>
          <div><span style=3D"font-size: 12pt;">-------------</span></div>
          <div><span style=3D"font-size: 12pt;">with cryptodev</span></div>
          <div><span style=3D"font-size: 12pt;">-------------</span></div>
          <div>
            <div>
              <div>The 'numbers' are in 1000s of bytes per second
                processed.</div>
              <div>type =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 16 bytes =
=C2=A0 =C2=A0 64 bytes =C2=A0 =C2=A0256 bytes =C2=A0
                1024 bytes =C2=A0 8192 bytes</div>
              <div>aes-128-cbc =C2=A0 =C2=A0 =C2=A045084.53k =C2=A0 191286.=
30k =C2=A0 656871.75k
                =C2=A03228385.28k 18282905.60k</div>
            </div>
          </div>
          <div>--------------</div>
          <div>compare the 8192 bytes per second processed, with
            cryptodev up to=C2=A0<span style=3D"font-size: 12pt;">18282905.=
60k,
              without is only=C2=A0</span><span style=3D"font-size: 12pt;">=
253359.45k,
              this is very good improved. don't look at that times of
              openssl speed -evp aes-128-cbc</span></div>
          <div><span style=3D"font-size: 12pt;"><br>
            </span></div>
          <div><span style=3D"font-size: 12pt;"><br>
            </span></div>
        </div>
      </div>
    </blockquote>
    as I wrote in another mail on this list, it's not openvpn but the
    'openssl speed' command which fails here:<br>
    <br>
    Try running this openssl command on your box:<br>
    <br>
    date ; cat bigfile | openssl enc -e -aes-256-cbc -bufsize 8192 -pass
    pass:testing123 &gt;=C2=A0 /dev/null ; date<br>
    <br>
    where 'bigfile' is some large file of &gt; 2 GB in size.<br>
    Then rerun it using<br>
    <br>
    date ; cat bigfile | openssl enc -engine cryptodev -e -aes-256-cbc
    -bufsize 8192 -pass pass:testing123 &gt;=C2=A0 /dev/null ; date<br>
    <br>
    and compare the results of the dates of 'before' and 'after'. On my
    hardware I takes ~ 10 seconds to encrypt a 3.3 GB file , with zero
    difference whether I use cryptodev or not, whereas 'openssl speed'
    reports a 100+ % improvement:<br>
    <br>
    with cryptodev module loaded:<br>
    =C2=A0=C2=A0 aes-256-cbc=C2=A0=C2=A0=C2=A0=C2=A0 286337.65k=C2=A0 10484=
23.31k=C2=A0 4589489.60k 19596646.40k
    141238272.00k<br>
    <br>
    without cryptodev:<br>
    =C2=A0=C2=A0 aes-256-cbc=C2=A0=C2=A0=C2=A0=C2=A0 465276.57k=C2=A0=C2=A0=
 487043.33k=C2=A0=C2=A0 493990.87k=C2=A0=C2=A0
    493776.90k=C2=A0=C2=A0 495720.11k<br>
    <br>
    <br>
    so, apart from the fact that openvpn's speed limitations are not
    determined solely by encryption/decryption, this does prove to me
    that the cryptodev device offers little if no performance
    improvement.<br>
    <br>
    hope this clears things up,<br>
    <br>
    JJK <br>
    <br>
  </body>
</html>

--------------040106020507070208040407--

