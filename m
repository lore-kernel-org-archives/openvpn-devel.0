References: <2987ae32-9a53-1888-11af-bf7d9741eecd@...2080...>
	<981f9961-a72f-727a-37de-a2741c8d73c9@...1227...>
	<4c5d5326-1ebe-95d0-9e0e-d3d6f1ef06d6@...515...>
	<20161102084852.vpeprssx3btfvini@...30...>
	<CAA1Abx+vU=GOCXaJ2mk33e+B=YtDCGEjaxfEmD6uHHppJ7qDNA@...278...>
	<bf81a9a2-a1a3-dbaf-5fbc-e32259f2c80d@...2080...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <44d14f78-621e-d707-6c66-9f448a61fafa@...515...>
Date: Wed, 2 Nov 2016 16:02:39 +0200
MIME-Version: 1.0
In-Reply-To: <bf81a9a2-a1a3-dbaf-5fbc-e32259f2c80d@...2080...>
Subject: Re: [Openvpn-devel] OpenVPN v2.4 release progress
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net, Steffan Karger <steffan@...1856...>

Il 02/11/2016 12:55, David Sommerseth ha scritto:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 02/11/16 10:32, Steffan Karger wrote:
>> Hi,
>>
>> On 2 November 2016 at 09:48, Alberto Gonzalez Iniesta
>> <agi@...64...> wrote:
>>> I don't know if 2.4 addresses building with openssl 1.1 [1], but
>>> that would be a plus.
>>
>> Not yet. The 1.1 API in considerably different from 1.0.x.
>> Switching is not very hard, but supporting both 1.0.x and 1.1 needs
>> some work. I would like to get this done before 2.4.0, but cannot
>> make any promises...  I'll put it on the release status page.
>
> Agreed it would be good to have this in 2.4.  If we can't make it for
> the final release, I think we need to have this in a later 2.4 release
> regardless.  I suspect more bleeding edge distros at some point next
> year will drop OpenSSL 1.0 completely.
>
> Unless we manage to improve our release cycle for 2.5 ... which
> wouldn't be a bad thing.
>

If we include only a few major features in each major release the 
problem is solved. One major release each year is certainly doable. I 
think we decided on that release cycle in way back when.

Samuli


>
> - --
> kind regards,
>
> David Sommerseth
> OpenVPN Technologies, Inc
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.22 (GNU/Linux)
>
> iQIcBAEBAgAGBQJYGcYrAAoJEIbPlEyWcf3yfucQALCHugfdugZPlHTXsyyNZS5V
> 2ypftfSSG8Wup00ZVzfg8SDSnJJuh/gDS7ufrNCKLGm3HKdW3iMQDS5bc53klJ2T
> eI06k8MAjTpSylqPvaT0FCCNmk7A/3Uk4LoLT69H45rlmETRNQEpn6IkFmjtgTNZ
> kiPz4SKbkOJf8Wv3wLW5rbUmJLf1irwcihqBV6ZXB2nqDUQh+iYKfrpB4lqytrM5
> EkszbA4NVmJC9melXRHEr9kZswnklywxvY+8lUiLI3Xu+4iWbWV3vhx/NlsOcGX0
> 85KlGk61OUO+rqS9E66rB3qioaONGtNu0JYnPcW4t8FPgMInHa3wNAnCxzpT4LIf
> Em3rKIkSQrsaH6QkAPliaAQU3R99q6WhTpHNX//woGAKNcVjFsIsQ4FbG5WnElQs
> Eu1nvTFjd2eQC0W4nhOLJhPdFrXl4KAZNP0hwg4zTDvZCRmcUAmEassLh5rT5cRu
> fW/1yoHK8Z+K4Kwt7/9Z7a1LyeCA3b0TRbKkhIIspjpRTDcyr85bjzX4FWNdcKhA
> CDYeaxmSGi8mWZV1xhU3HD24NqY7qjlDrjYqp51sb8vFcU2AKO0SXeWByB80sIgQ
> PhVNSmH97/OqV9mLNdQWT3nJBrxcYM6AUhMQ2ceZh6+deZSN4WKCOf0ufNoyReWv
> AdEMEadUeTMMJROM03Ey
> =luns
> -----END PGP SIGNATURE-----
>
> ------------------------------------------------------------------------------
> Developer Access Program for Intel Xeon Phi Processors
> Access to Intel Xeon Phi processor-based developer platforms.
> With one year of Intel Parallel Studio XE.
> Training and support from Colfax.
> Order your platform today. http://sdm.link/xeonphi
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

