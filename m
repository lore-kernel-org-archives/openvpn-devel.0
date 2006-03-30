Message-ID: <20060330154210.67343.qmail@...574...>
From: Iftikhar Qureshi <iftikharqureshi@...109...>
Subject: RE: [Openvpn-devel] OpenVPN for PocketPC
In-Reply-To: <000001c6528a$f79501e0$1601a8c0@...576...>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-82710337-1143733329=:66374"
Content-Transfer-Encoding: 8bit
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Mar 30 07:43:04 2006
To: openvpn-devel@lists.sourceforge.net

--0-82710337-1143733329=:66374
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Dave,
 
 I've got the latest code. TAPTester compiles without any error.
 
 I'm using Win 2003 as my OpenVPN server. Could you send me the server configuration file that you used for testing. Did you use emulator for ping test?
 
 Salamz,
 -IQ
 

Dave <dev@...575...> wrote:Iftikhar;

If interested, I just updated the source to correct a bug (previously you
had to specify the dev-node option) and to emulate supporting the nobind
option.  You still have to use the ip-win32 ipapi option.

Also, I have some initial good news.  I have successfully ping'ed the
server-side end of the tunnel.  This means data is flowing through the
driver and protocol stack correctly, from server to openvpn.exe.

I used a very minimal server configuration.  Now I need to figure out how to
set up more options so I probably won't be coding anything for a couple
days.

-Dave

--0-82710337-1143733329=:66374
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Dave,<br> <br> I've got the latest code. TAPTester compiles without any error.<br> <br> I'm using Win 2003 as my OpenVPN server. Could you send me the server configuration file that you used for testing. Did you use emulator for ping test?<br> <br> Salamz,<br> -IQ<br> <br><br><b><i>Dave &lt;dev@...575...&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;">Iftikhar;<br><br>If interested, I just updated the source to correct a bug (previously you<br>had to specify the dev-node option) and to emulate supporting the nobind<br>option.  You still have to use the ip-win32 ipapi option.<br><br>Also, I have some initial good news.  I have successfully ping'ed the<br>server-side end of the tunnel.  This means data is flowing through the<br>driver and protocol stack correctly, from server to openvpn.exe.<br><br>I used a very minimal server configuration.  Now I need to figure out how to<br>set up more options so
 I probably won't be coding anything for a couple<br>days.<br><br>-Dave</blockquote><br>
--0-82710337-1143733329=:66374--

