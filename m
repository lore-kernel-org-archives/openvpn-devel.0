MIME-Version: 1.0
In-Reply-To: <20120326182231.GZ1359@...1296...>
References: <20120326160546.GV1359@...1296...>
	<CAOazyz1W7ZcVEhDwq0DWCOjQ_DetcjP6yDg1MhOPiMYqu2Sr6w@...278...>
	<20120326175543.GX1359@...1296...>
	<CAOazyz2OxeRdL1+SfzrCw6YDnLnY5Yg-PCq9K6041Dgvs_W2hg@...278...>
	<CAOazyz3gFfBT-xniAiziy36kiDcqL=0mVQvKc0KHYEjt_vPh8A@...278...>
	<20120326182231.GZ1359@...1296...>
Date: Mon, 26 Mar 2012 20:32:40 +0200
Message-ID: <CAOazyz0qSzNnGAZj4t43EcKn+nLCGpet0oTXkTQOfQuZ4pfb4A@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [DISCUSS] much more complicated gcc invocations
	now
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Mar 26, 2012 at 8:22 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Mon, Mar 26, 2012 at 08:14:50PM +0200, Alon Bar-Lev wrote:
>> Are for dependency tracking, so that if you change a file dependencies
>> will be recompiled... This was the same in previous build.
>>
>> So we had:
>> ---
>> gcc -DHAVE_CONFIG_H -I. =C2=A0 -I. -I/usr/kerberos/include =C2=A0 =C2=A0=
-g -O2 -MT
>> status.o -MD -MP -MF .deps/status.Tpo -c -o status.o status.c
>> ---
>
> Fine with me...
>
>> And now:
>> ---
>> if gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I../../include
>> -I../../src/compat =C2=A0 =C2=A0 =C2=A0-I/usr/include -I/usr/include =C2=
=A0 =C2=A0 -g -O2 -MT
>> status.o -MD -MP -MF ".deps/status.Tpo" -c -o status.o status.c; =C2=A0t=
hen
>> mv -f ".deps/status.Tpo" ".deps/status.Po"; else rm -f
>> ".deps/status.Tpo"; exit 1; fi
>> ---
>
> ... convolution. =C2=A0Even the quotation marks get inflation now.
>
>> What this makes sure is that if compile fails the dependencies is remove=
d....
>
> Why would anyone want to do that, on a production build?
>
>
> But anyway. =C2=A0I've stated my opinion, you've stated yours, and now it=
's
> up to the rest of the community to form a "community decision" which is
> the way to go.
>
> Thanks for explaining your view - I sometimes can't help myself, I'm an
> old-fashioned programmer who writes Makefiles by hand and has a dislike
> for automation that's brittle enough to require careful tending...

And I thought that I am old-fashioned!

Well, please hold... I don't see this if... at my machine:

---
gcc -DHAVE_CONFIG_H -I. -I../../../src/openvpn -I../..
-I../../../include -I../../../src/compat    -I/usr/kerberos/include
-I/usr/kerberos/include     -g -O2 -MT reliable.o -MD -MP -MF
.deps/reliable.Tpo -c -o reliable.o ../../../src/openvpn/reliable.c
mv -f .deps/reliable.Tpo .deps/reliable.Po
gcc -DHAVE_CONFIG_H -I. -I../../../src/openvpn -I../..
-I../../../include -I../../../src/compat    -I/usr/kerberos/include
-I/usr/kerberos/include     -g -O2 -MT route.o -MD -MP -MF
.deps/route.Tpo -c -o route.o ../../../src/openvpn/route.c
mv -f .deps/route.Tpo .deps/route.Po
gcc -DHAVE_CONFIG_H -I. -I../../../src/openvpn -I../..
-I../../../include -I../../../src/compat    -I/usr/kerberos/include
-I/usr/kerberos/include     -g -O2 -MT schedule.o -MD -MP -MF
.deps/schedule.Tpo -c -o schedule.o ../../../src/openvpn/schedule.c
mv -f .deps/schedule.Tpo .deps/schedule.Po
gcc -DHAVE_CONFIG_H -I. -I../../../src/openvpn -I../..
-I../../../include -I../../../src/compat    -I/usr/kerberos/include
-I/usr/kerberos/include     -g -O2 -MT session_id.o -MD -MP -MF
.deps/session_id.Tpo -c -o session_id.o
../../../src/openvpn/session_id.c
mv -f .deps/session_id.Tpo .deps/session_id.Po
gcc -DHAVE_CONFIG_H -I. -I../../../src/openvpn -I../..
-I../../../include -I../../../src/compat    -I/usr/kerberos/include
-I/usr/kerberos/include     -g -O2 -MT shaper.o -MD -MP -MF
.deps/shaper.Tpo -c -o shaper.o ../../../src/openvpn/shaper.c
mv -f .deps/shaper.Tpo .deps/shaper.Po
gcc -DHAVE_CONFIG_H -I. -I../../../src/openvpn -I../..
-I../../../include -I../../../src/compat    -I/usr/kerberos/include
-I/usr/kerberos/include     -g -O2 -MT sig.o -MD -MP -MF .deps/sig.Tpo
-c -o sig.o ../../../src/openvpn/sig.c
mv -f .deps/sig.Tpo .deps/sig.Po
gcc -DHAVE_CONFIG_H -I. -I../../../src/openvpn -I../..
-I../../../include -I../../../src/compat    -I/usr/kerberos/include
-I/usr/kerberos/include     -g -O2 -MT socket.o -MD -MP -MF
.deps/socket.Tpo -c -o socket.o ../../../src/openvpn/socket.c
mv -f .deps/socket.Tpo .deps/socket.Po
gcc -DHAVE_CONFIG_H -I. -I../../../src/openvpn -I../..
-I../../../include -I../../../src/compat    -I/usr/kerberos/include
-I/usr/kerberos/include     -g -O2 -MT socks.o -MD -MP -MF
.deps/socks.Tpo -c -o socks.o ../../../src/openvpn/socks.c
mv -f .deps/socks.Tpo .deps/socks.Po
gcc -DHAVE_CONFIG_H -I. -I../../../src/openvpn -I../..
-I../../../include -I../../../src/compat    -I/usr/kerberos/include
-I/usr/kerberos/include     -g -O2 -MT ssl.o -MD -MP -MF .deps/ssl.Tpo
-c -o ssl.o ../../../src/openvpn/ssl.c
mv -f .deps/ssl.Tpo .deps/ssl.Po
gcc -DHAVE_CONFIG_H -I. -I../../../src/openvpn -I../..
-I../../../include -I../../../src/compat    -I/u
---

Alon.

