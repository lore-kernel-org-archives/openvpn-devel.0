Message-ID: <4F4A4929.6040407@...1030...>
Date: Sun, 26 Feb 2012 15:00:57 +0000
From: Mr Dash Four <mr.dash.four@...1030...>
MIME-Version: 1.0
References: <4F466205.5020006@...1030...>	<CAOazyz24mNbDRf0zoCMHrdCsrZui+cgWaETt7AA67qShfs4bGw@...278...>	<4F4978D2.70706@...1030...>	<CAOazyz2jCkj2ox9edFap05zze2i5-pW1J9W4ho=jSVhZTUZQFw@...278...>	<4F4A31E1.2080503@...1030...>
	<CAOazyz1n6Uz3TuSywisO41J=tjNJ94rbq7LUgw5y3b+dR0J8nA@...278...>
In-Reply-To: <CAOazyz1n6Uz3TuSywisO41J=tjNJ94rbq7LUgw5y3b+dR0J8nA@...278...>
Subject: Re: [Openvpn-devel] static build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net


> You can check if executable is static by using
> arm-unknown-linux-gnueabi-readelf --relocas.
> The fact that the archive has a lot of files does not mean the openvpn
> is not static.
>   
Well, I don't really know what you understand "static linking" to be, 
but to me it means that all external functions, subroutines etc, which 
are resolved at compile-time, are copied into a target application by 
the gcc linker, producing an object file and then a stand-alone 
executable ("stand-alone" being the key word here!). Your build script, 
evidently, does not do that and I already pointed out the changes you 
may need to make to allow a *stand-alone* openvpn executable to be produced.

If you believe "static linking" to mean something else from what I 
described above, please enlighten us all!

If I have to deploy additional files alongside openvpn, then I may as 
well have it dynamically linked and deploy the entire dependencies chain 
(using ldd as guidance). The reason I can't/won't do that is because to 
satisfy this, I have to 1) spend a lot of my time digging out 
dependencies, without the guarantee that it would ever work, and 2) as 
my rootfs is read-only, whatever I do it will be instantly lost on 
reboot, so the whole exercise would be utterly pointless.

> Anyway it is working at my side, and it is a standard process.
> You can adjust the script for your needs.
>   
I already did, you may as well do the same and make the changes I 
suggested earlier for the "really_static" option to really work, 
because, as it stands, "really_static" isn't so as openvpn still needs 
external files to operate.

