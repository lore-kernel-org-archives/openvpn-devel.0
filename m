Message-ID: <a10961760603100531s464597b1t@...278...>
From: "Janne Johansson" <icepic.dz@...277...>
Subject: Re: [Openvpn-devel] using other compression algorithms with OPENVPN -- HELP
In-Reply-To: <BAY17-F14480E6E6C8D20ACF02F80F9EC0@...512...>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_11937_21992919.1141997486013"
References: <BAY17-F14480E6E6C8D20ACF02F80F9EC0@...512...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Mar 10 05:32:02 2006
To: Anne Mindika Silva <anne_mindika@...160...>
Cc: openvpn-devel@lists.sourceforge.net

------=_Part_11937_21992919.1141997486013
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

2006/3/9, Anne Mindika Silva <anne_mindika@...160...>:
>
> hi,
>
> We are trying to biuld a network compression tool which will compress the
> data that is transfered between two machines.  While lzo, performs very
> well
> for text-based data, we thought it would be nice to use different
> compression algorithms for different types of data.
>
> Since OPENVPN supports lzo compression we are using that for the initial
> version.  We also noticed that the compression is done at the packet
> level.
>   Is there any way that we can specify an additional compression algorithm
> to be used ?
>
> If we have for e.g.,  basically two types to data that is sent over the
> network,  lets say one type  that compresses well with lzo, and another
> type
> that is better when compressed with another algorithm (or that is better
> off
> uncompressed),   does that mean we'll have to run two instances of
> OPENVPN?



I think that 99% of all compressors will be good at the same kind of data
that
lzo is good at, though they might be a couple of percents better than lzo at
the expense of many more cpu cycles. It would probably be very hard to find
a compressor that would give you real speedups due to smaller packets
without
being too heavy on the cpu and slow down traffic that way.

Try to replace lzo with something else and make benchmarks for your setup
first,
and worry about having multiple instances later, I'd say.

--
Some mornings, it's just not worth gnawing through the straps...

------=_Part_11937_21992919.1141997486013
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br><div><span class=3D"gmail_quote">2006/3/9, Anne Mindika Silva &lt;<=
a href=3D"mailto:anne_mindika@...160...">anne_mindika@...160...</a>&gt;:</s=
pan><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(2=
04, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
hi,<br><br>We are trying to biuld a network compression tool which will com=
press the<br>data that is transfered between two machines.&nbsp;&nbsp;While=
 lzo, performs very well<br>for text-based data, we thought it would be nic=
e to use different
<br>compression algorithms for different types of data.<br><br>Since OPENVP=
N supports lzo compression we are using that for the initial<br>version.&nb=
sp;&nbsp;We also noticed that the compression is done at the packet level.<=
br>&nbsp;&nbsp;Is there any way that we can specify an additional compressi=
on algorithm
<br>to be used ?<br><br>If we have for e.g.,&nbsp;&nbsp;basically two types=
 to data that is sent over the<br>network,&nbsp;&nbsp;lets say one type&nbs=
p;&nbsp;that compresses well with lzo, and another type<br>that is better w=
hen compressed with another algorithm (or that is better off
<br>uncompressed),&nbsp;&nbsp; does that mean we'll have to run two instanc=
es of OPENVPN?</blockquote><div><br><br>I think that 99% of all compressors=
 will be good at the same kind of data that<br>lzo is good at, though they =
might be a couple of percents better than lzo at
<br>the expense of many more cpu cycles. It would probably be very hard to =
find<br>a compressor that would give you real speedups due to smaller packe=
ts without<br>being too heavy on the cpu and slow down traffic that way.
<br></div><br>Try to replace lzo with something else and make benchmarks fo=
r your setup first,<br>and worry about having multiple instances later, I'd=
 say.<br></div><br>-- <br>Some mornings, it's just not worth gnawing throug=
h the straps...
<br>

------=_Part_11937_21992919.1141997486013--

