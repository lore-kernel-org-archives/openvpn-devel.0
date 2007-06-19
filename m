Message-ID: <2d049d4d0706191256v5690064btbff6954471ed3f69@...278...>
Date: Tue, 19 Jun 2007 16:56:20 -0300
From: "Rafael Ruppel" <ruppel@...1033...>
Sender: rruppel@...277...
In-Reply-To: <2d049d4d0706191253n6190559dh597b2c45e63ee49d@...278...>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_102672_5547.1182282980623"
References: <2d049d4d0706190813w1fa792b4qf6e53b68d18643c0@...278...>
	<2d049d4d0706191253n6190559dh597b2c45e63ee49d@...278...>
Subject: Re: [Openvpn-devel] How check if its correctly built,
	and how to generate installer script?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

------=_Part_102672_5547.1182282980623
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I think I have built OpenVPN at Windows (using MingW and MSYS). I have built
OpenSSL, then I built LZO and then I have built OpenVPN changing the path of
OpenSSL and LZO at makefile.w32. (I think this is the right way to compile
OpenVPN).

But then I want know how can I check if it was corrected compiled, and how
can I create the script?

The nsi script inside the install-w32 folder links to a "bin" folder, but
after I built the openvpn there isnt any "bin" folder, just the openvpn.exe

So i dnt know if I correctly built the OpenVPN (I didnt build the TAP
driver, but I think that isnt necessary), or if the script is wrong... or I
miss another thing.

I appreciate any help.

Regards

Rafael Ruppel Ruiz

------=_Part_102672_5547.1182282980623
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I think I have built OpenVPN at Windows (using MingW and
MSYS). I have built OpenSSL, then I built LZO and then I have built
OpenVPN changing the path of OpenSSL and LZO at makefile.w32. (I think
this is the right way to compile OpenVPN).
<br><br>But then I want know how can I check if it was corrected compiled, and how can I create the script?<br><br>The
nsi script inside the install-w32 folder links to a &quot;bin&quot; folder, but
after I built the openvpn there isnt any &quot;bin&quot; folder, just the
openvpn.exe<br><br>So i dnt know if I correctly built the OpenVPN (I
didnt build the TAP driver, but I think that isnt necessary), or if the
script is wrong... or I miss another thing.<br><br>I appreciate any help.<br><br>
Regards<br><span class="sg"><br>Rafael Ruppel Ruiz</span>

------=_Part_102672_5547.1182282980623--

