In-Reply-To: <200704191746.47385.bfg@...1012...>
References: <A06302D8-1633-4FCB-A8EE-8EC6A58FF3F3@...1018...>
	<200704191746.47385.bfg@...1012...>
Mime-Version: 1.0 (Apple Message framework v752.3)
Message-Id: <4B26AA2B-5DA4-4585-89B2-D76F4BB52518@...1018...>
From: Dave Cramer <davec@...1018...>
Date: Thu, 19 Apr 2007 12:53:04 -0400
Subject: Re: [Openvpn-devel] learn address problems with chroot, or userid
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; delsp=yes; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "=?UTF-8?Q?Brane_F._Gra=C4=8Dnar?=" <bfg@...1012...>
Cc: openvpn-devel@lists.sourceforge.net

doh!

Thanks
On 19-Apr-07, at 11:46 AM, Brane F. Gra=C4=8Dnar wrote:

> On Thursday 19. April 2007 14:51, Dave Cramer wrote:
>> The only way I can get learn-address script to work is by running
>> openvpn as root
>>
>> Ideally I'd like to create an openvpn user, and chroot to /
>> openvpnprivate/
>>
>> then run
>>
>> learn-address /script
>>
>> However when I tried this I get "cannot execute cmd"  error
>
> Inside chroot you need:
>
> /bin/sh (system(3) spawns command using sh -c)
> /lib or /lib64 directory with all libraries that are linked against=20=20
> your sh.
>
> Run ldd /bin/sh to get list of linked libraries.
>
> Hope this helps...
>
> cheers,
> --=20
> Brane F. Gra=C4=8Dnar
> Sistemski administrator za UNIX okolje
> Interseek d.o.o., Stegne 31, SI-1000 Ljubljana
> e-mail > bfg@...1012...
> www.interseek.si, www.najdi.si
>
> ----------------------------------------------------------------------=20
> ---
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


