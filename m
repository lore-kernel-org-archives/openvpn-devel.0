Message-ID: <4FABB7CD.8060109@...515...>
Date: Thu, 10 May 2012 15:42:53 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4FAAE0A1.2080808@...1227...>
	<CAOazyz2wZ3n-70Pk8W_Z3OE_4_4th1PXWUOZUjOjNXetPkxc7g@...278...>
	<4FAAF152.7070508@...1227...>
	<CAOazyz35bB=q1hpdzjj_aHZ7K_0koT8pcw0csham2AOwMqGrfg@...278...>
	<4FAAF945.8070005@...1227...>
	<CAOazyz12Rw0kOSS+siU7tLP4eXO5XkhexjVLn+uC97s4K1Z8EQ@...278...>
	<4FAAFCB4.8040606@...1227...>
	<CAOazyz2wP2ms7HC31LPp3VzFRBu+S3zURZm1ozz0MzjmhQv07g@...278...>
	<4FAB0556.50903@...1227...>
	<CAOazyz2pdJysuaEhoDL8O=S=CdEfW8XCuB6n8YrnKjOBqstTPA@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8A98@...1436...>
	<CAOazyz0Qb8xa-FUqQcMDX=w+=Vb3J8sQ2R8GAxNtfWxT-4DNkw@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8AB9@...1436...>
	<CAOazyz3xObLvBubo4E6vSmepj-8AkGd6P4k-6VXYpvsSm-vs3A@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8AD6@...1436...>
	<4FAB8EEE.8020607@...1114...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8BB0@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B9012D1CF8BB0@...1436...>
Subject: Re: [Openvpn-devel] [PATCH] Openvpn for Android 4.0 Changeset
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Adriaan de Jong <dejong@...1435...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>
>> -----Original Message-----
>> From: David Sommerseth [mailto:openvpn.list@...1114...]
>> Sent: donderdag 10 mei 2012 11:49
>> To: Alon Bar-Lev
>> Cc: Adriaan de Jong; openvpn-devel@lists.sourceforge.net
>> Subject: Re: [Openvpn-devel] [PATCH] Openvpn for Android 4.0 Changeset
>>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 10/05/12 09:28, Adriaan de Jong wrote:
>>> I still prefer using the management interface. It keeps the interface
>>> to the Java stuff very clean (socket-based). Further you potentially
>>> allow other systems, such as Apple or Windows Phone to do the same.
>> It
>>> avoids messy JNI stuff, and fits into the spirit of the management
>>> interface. It's the simplest solution.
>> I agree.  The plug-in approach seems a bit overkill to me.  The
>> approach using the management API makes it far simpler.
>>
>> Bear in mind that Windows Phone 7 support will probably be asked for at
>> some point - we have no idea how that will really work out now.  We
>> have users wanting support for iPhone/iPad.  The plug-in approach means
>> to write both a suitable plug-in for the platform and the front-end
>> app.  Using just the management API, you just need to write the GUI
>> which does all the needed gluing on the native platforms in that app,
>> just how it wants it.
>>
>>
> In fact, it's theoretically even a way to remove the need for root rights=
 for the OpenVPN executable, and moving them towards a different, simpler a=
pp.
>
>
Speaking of Windows Phone 7 and iPhone/iPad.... afaik[1] their
respective application stores prohibit apps with reciprocal licenses
(e.g. GPLv2). Is there any way to work around this arbitrary limitations
without a complete rewrite? Having to root one's iPhone/iPad/Windows
Phone to use OpenVPN sounds silly.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


[1]
<http://arstechnica.com/information-technology/2011/02/windows-phone-market=
place-bans-the-gpl-and-the-app-store-should-too>


