From: Kristof Provost <kp@...1376...>
Date: Mon, 22 Aug 2022 20:28:17 +0200
Message-ID: <A603B887-D43D-4FA9-80B7-3ACD6373B662@...1376...>
In-Reply-To: <YwPH6uZzbYAJ3UeP@...1296...>
References: <20220812134154.16729-3-kprovost@...2661...>
 <202208201401.27KE12Cm014083@...2054...>
 <YwDwvG++hK0nJI2F@...1296...>
 <21B552DE-38FE-41F0-8FC7-606EA4C06093@...1376...>
 <YwPH6uZzbYAJ3UeP@...1296...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=_MailMate_88FEFF15-033E-412E-BF3B-C076110C0FEB_="
Subject: Re: [Openvpn-devel] route/iroute handling on FreeBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--=_MailMate_88FEFF15-033E-412E-BF3B-C076110C0FEB_=
Content-Type: text/plain

On 22 Aug 2022, at 20:16, Gert Doering wrote:
> On Mon, Aug 22, 2022 at 02:55:09PM +0200, Kristof Provost wrote:
>>> Now, back to FreeBSD.
>>>
>>>   - our code does not try to set metrics on FreeBSD
>>>   - my reading of route(8) does not show me anything in that direction
>>>     (metric, preference, administrative distance, ...)
>>>   - I do not understand FreeBSD internals well enough to know whether
>>>     it can be done at all, or not.
>>>
>> It???s rather poorly (i.e. not) documented, but it is possible to set a
>> route metric. It???s called a ???weight???, and not actually mentioned
>> in the man page. Or shown in netstat output.
>>
>> But:
>>
>> 	$ sudo route add 172.16.2.0/24 10.0.2.1
>> 	add net 172.16.2.0: gateway 10.0.2.1
>> 	$ sudo route add 172.16.2.0/24 -weight 2 10.0.2.254
>> 	add net 172.16.2.0: gateway 10.0.2.254
>
> Oh, this is interesting, and good to know.
>
> What is the default weight?  "1"?
Yes, the default is RT_DEFAULT_WEIGHT:

	/usr/include/net/route.h
	105:#define	RT_DEFAULT_WEIGHT	1

Best regards,
Kristof
--=_MailMate_88FEFF15-033E-412E-BF3B-C076110C0FEB_=
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/xhtml; charset=3Dutf-8">
</head>
<body><div style=3D"font-family: sans-serif;"><div class=3D"markdown" style=
=3D"white-space: normal;">
<p dir=3D"auto">On 22 Aug 2022, at 20:16, Gert Doering wrote:</p>
</div><div class=3D"plaintext" style=3D"white-space: normal;"><blockquote s=
tyle=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px solid #136BCE;=
 color: #136BCE;"><p dir=3D"auto">On Mon, Aug 22, 2022 at 02:55:09PM +0200,=
 Kristof Provost wrote:</p>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px s=
olid #136BCE; border-left-color: #4B89CF; color: #4B89CF;"><blockquote styl=
e=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px solid #136BCE; bo=
rder-left-color: #4B89CF; color: #4B89CF;"><p dir=3D"auto">Now, back to Fre=
eBSD.</p>
<p dir=3D"auto">  - our code does not try to set metrics on FreeBSD
<br>
  - my reading of route(8) does not show me anything in that direction
<br>
    (metric, preference, administrative distance, ...)
<br>
  - I do not understand FreeBSD internals well enough to know whether
<br>
    it can be done at all, or not.</p>
</blockquote><p dir=3D"auto">It???s rather poorly (i.e. not) documented, bu=
t it is possible to set a
<br>
route metric. It???s called a ???weight???, and not actually mentioned
<br>
in the man page. Or shown in netstat output.</p>
<p dir=3D"auto">But:</p>
<p dir=3D"auto">	$ sudo route add 172.16.2.0/24 10.0.2.1
<br>
	add net 172.16.2.0: gateway 10.0.2.1
<br>
	$ sudo route add 172.16.2.0/24 -weight 2 10.0.2.254
<br>
	add net 172.16.2.0: gateway 10.0.2.254</p>
</blockquote><p dir=3D"auto">Oh, this is interesting, and good to know.</p>
<p dir=3D"auto">What is the default weight?  "1"?</p>
</blockquote></div>
<div class=3D"markdown" style=3D"white-space: normal;">
<p dir=3D"auto">Yes, the default is RT_DEFAULT_WEIGHT:</p>
<pre style=3D"margin-left: 15px; margin-right: 15px; padding: 5px; border: =
thin solid gray; overflow-x: auto; max-width: 90vw; background-color: #E4E4=
E4;"><code>/usr/include/net/route.h
105:#define	RT_DEFAULT_WEIGHT	1
</code></pre>
<p dir=3D"auto">Best regards,<br>
Kristof</p>

</div></div></body>

</html>

--=_MailMate_88FEFF15-033E-412E-BF3B-C076110C0FEB_=--

