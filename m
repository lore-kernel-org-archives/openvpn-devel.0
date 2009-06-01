Date: Mon, 1 Jun 2009 09:15:43 +0400
From: Victor Wagner <vitus@...1066...>
Message-ID: <20090601051543.GA15965@...1066...>
References: <f9615cc80905271048v646f546fod19ecec32c2a172a@...278...>
	<20090528055401.GB24851@...1066...> <4A210CB1.6050802@...41...>
MIME-Version: 1.0
In-Reply-To: <4A210CB1.6050802@...41...>
Subject: Re: [Openvpn-devel] Unable to use -OFB or -CFB ciphers in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On 2009.05.30 at 04:38:41 -0600, James Yonan wrote:

> 
> The OFB and CFB cipher modes in OpenVPN have not been well-tested and 
> should be considered experimental at this point.
  

> They are not compiled by default mostly to prevent someone from 
> accidentally using them.

Okay, you see there is some demand for this cipher.

Can anybody explain why such strange design decision is taken.

As far as I know cryptography theory, there is absolutely no reason to
prefer CBC to CFB or CNT.

