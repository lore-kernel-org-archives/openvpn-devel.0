References: <4e9afe58-f398-7163-18fe-9113bf0cdfbc@...277...>
	<283c21d2-c51c-b2e6-0c5e-5055b6bec3cd@...515...>
	<12c6df78-5506-886f-93f3-a13ed99662a4@...2080...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <dc4fab4d-ee6a-3ef3-6c31-8e2738c7683d@...515...>
Date: Thu, 22 Sep 2016 19:21:48 +0300
MIME-Version: 1.0
In-Reply-To: <12c6df78-5506-886f-93f3-a13ed99662a4@...2080...>
Subject: Re: [Openvpn-devel] Linux: Use /tmp for log problem ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net, debbie10t <debbie10t@...277...>


>> Basically --log and --log-append will work, if the logfile is
>> stored under /etc/openvpn. If you try to put the it under /tmp, it
>> will never appear.
>
> Eeek ... never suggest putting log data into /etc ... /var/log please!

Just for the record: I was not suggesting putting the logfiles there. I=20
just had hunch /tmp was the issue, and I was right.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

