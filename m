Message-Id: <39E081EA-318B-4A34-A391-C7CA5BB511BA@...1348...>
From: Toby Thain <toby@...1348...>
In-Reply-To: <4E8CFE17-2394-4FAD-A1A5-AF193D97E7A3@...1348...>
Mime-Version: 1.0 (Apple Message framework v936)
Date: Tue, 27 Apr 2010 13:03:11 +1000
References: <1272334773.8910.2@...1207...>
	<4E8CFE17-2394-4FAD-A1A5-AF193D97E7A3@...1348...>
Subject: Re: [Openvpn-devel] Unpackaged Windows binaries (Was: Re:
	[Openvpn-users] [ANN] OS X packages - OpenVPN 2.1.1)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="WINDOWS-1252"; delsp=yes; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net


On 27-Apr-10, at 12:46 PM, Toby Thain wrote:

>
> On 27-Apr-10, at 12:19 PM, Karl O. Pinc wrote:
>
>> On 04/26/2010 06:19:31 PM, Toby Thain wrote:
>>>>
>>>>
>>>
>>> I don't think unpackaged OS X binaries are very useful, which is why
>>> I
>>>
>>> created the pkg+dmg.
>>
>> I agree, because the Apple development kit is shipped,
>> if not installed, on every Mac.
>
> It ships on the DVD but most people never install it, of course.
>
>> (Last I looked.)  And
>> because ./configure ; make is painless.
>
> To use your argument from above -- imho much too complex for most end
> users. As well as requiring Apple Developer Tools (they have to go
> find the original DVD, which may or may not even be possible), this
> involves locating and downloading two source archives from two
> different sites, and configuring and building them both;

I left out some other items that the package includes:
=96 the XML service metadata (plist) that doesn't exist in the source=20=20
distribution
=96 launchd service setup

So it's really well beyond the "end user" realm...

(More details: http://telegraphics.com.au/svn/openvpn-package/trunk/README=
=20
  )

This is probably solved in other ways by 3rd party OpenVPN derivatives=20=20
out there, but imho there should still be an 'official' binary=20=20
installer.

--Toby

> beyond the
> pale for non-technical users, even though it's trivial for "us".
>
> The pkg/dmg is, on the other hand, a genuine one click install.

