Message-ID: <4B5F33E4.5080508@...1299...>
Date: Wed, 27 Jan 2010 07:26:44 +1300
From: Jason Haar <Jason.Haar@...1299...>
MIME-Version: 1.0
References: <4B5E2895.4030906@...1299...> <1264523745.26411.1@...1207...>
In-Reply-To: <1264523745.26411.1@...1207...>
Subject: Re: [Openvpn-devel] win32 openvpn-2.1.1 has bug with "nobind"?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 01/27/2010 05:35 AM, Karl O. Pinc wrote:
>
> Sounds like the 2MSL problem described in this thread:
> http://sourceforge.net/mailarchive/forum.php?thread_name=1263527105.29484.1%40mofo&forum_name=openvpn-devel
>
>   
I see what you mean - not the same issue - but the same cause (and
affecting UDP as well as TCP). I don't get it - what does "nobind"
actually do then? The manpage states

Do  not bind to local address and port.  The IP stack will allocate a
dynamic port for returning packets

That just seems to be totally not the case. With "nobind" set, openvpn
still explicitly binds to 1194. I always read the manpage as meaning
"nobind" meant "let the OS decide what port to use". In fact, I just
tried "lport 22222" and that didn't work either! It still used 1194.


-- 
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +64 3 9635 377 Fax: +64 3 9635 417
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


