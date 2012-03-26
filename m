MIME-Version: 1.0
In-Reply-To: <20120326184719.GA1359@...1296...>
References: <20120326160546.GV1359@...1296...>
	<CAOazyz1W7ZcVEhDwq0DWCOjQ_DetcjP6yDg1MhOPiMYqu2Sr6w@...278...>
	<20120326175543.GX1359@...1296...>
	<CAOazyz2OxeRdL1+SfzrCw6YDnLnY5Yg-PCq9K6041Dgvs_W2hg@...278...>
	<CAOazyz3gFfBT-xniAiziy36kiDcqL=0mVQvKc0KHYEjt_vPh8A@...278...>
	<20120326182231.GZ1359@...1296...>
	<CAOazyz0qSzNnGAZj4t43EcKn+nLCGpet0oTXkTQOfQuZ4pfb4A@...278...>
	<20120326184719.GA1359@...1296...>
Date: Mon, 26 Mar 2012 20:50:06 +0200
Message-ID: <CAOazyz2KhywpoB=fsetWLwO9dor_1UDi6xWwos_tkF3qb7YcVw@...278...>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Mar 26, 2012 at 8:47 PM, Gert Doering <gert@...1296...> wrote:
> (Just as a side note - why is it including "-I/usr/kerberos/include" *twice*
> for you?)

As we use both libcrypto and libssl we get this twice...
---
$ pkg-config --cflags libcrypto
-I/usr/kerberos/include
$ pkg-config --cflags libssl
-I/usr/kerberos/include
---

Alon.

