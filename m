Message-ID: <4F4A31E1.2080503@...1030...>
Date: Sun, 26 Feb 2012 13:21:37 +0000
From: Mr Dash Four <mr.dash.four@...1030...>
MIME-Version: 1.0
References: <4F466205.5020006@...1030...>	<CAOazyz24mNbDRf0zoCMHrdCsrZui+cgWaETt7AA67qShfs4bGw@...278...>	<4F4978D2.70706@...1030...>
	<CAOazyz2jCkj2ox9edFap05zze2i5-pW1J9W4ho=jSVhZTUZQFw@...278...>
In-Reply-To: <CAOazyz2jCkj2ox9edFap05zze2i5-pW1J9W4ho=jSVhZTUZQFw@...278...>
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


>> Reason being, I suspect, that the lzo static libraries cannot be found (strange as the compilation succeeded).
>>     
>
> I need tmp/openvpn/config.log
> Better to have the complete build output...
>   
This was done in mock environment (both the rpm and "normal" build). 
When I did this from outside, using a specific arm cross-toolchain, the 
build succeeded, *but* the package created does not contain static 
openvpn - it still needs all of its dependencies (though them being 
statically-build components, like lzo etc). The output produced from 
your build script seems to be an archive, presumably containing all the 
files openvpn needs, spread across multiple directories (I am also not 
sure whether openvpn produced in this way won't need its libgc library).

I suspect all I need to do is to unpack this archive to the target, but 
that won't do me any good at all, because my root system on the android 
device is squashfs (read-only) and whatever I do with it (provided I 
succeed) will be destroyed the next time I reboot the device. What I 
need is a single openvpn executable, so that I could just place it 
somewhere in my path and fire it off.

I was able to slightly amend the running order of openvpn compilation 
process and succeeded in building a single, statically-linked openvpn 
executable for my android device.

The error your build script has with this is that the last statement 
which links all objects into the openvpn executable should contain 
"-static", "-static-libgcc" along with "-ldl" - currently you don't have 
that and the openvpn executable produced is about 700kB, still needing 
its static libraries at the very least.

When openvpn is statically linked in the way I just described, the file 
produced is about 7MB, coming down to about 1.7MB after stripping. 
Copying this single file to my android device (and briefly testing it) 
seems to have done the trick.

One drawback from this, which is valid for *all* statically-linked 
executables in this way, is that there are some arch-dependent 
functions, like "gethostbyname", which are implemented, possibly in a 
different way in different environments, hence when I statically link 
and produce one single monolithic executable in such a way I get a 
warning from the linker, but since I am not likely to use such 
functions, I think there is nothing to worry about.

