Message-ID: <b5d7ac620901201300sf2fb8b6t23849aa48d7725ed@...278...>
Date: Tue, 20 Jan 2009 15:00:13 -0600
From: "Luis Enrique Amaya Gonzalez" <luisenrique.amayagonzalez@...277...>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_11645_29608003.1232485213748"
Subject: [Openvpn-devel] weird problem
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

------=_Part_11645_29608003.1232485213748
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi guys

 I'm trying to compile openvpn-2.1_rc1[3-5] in a WIN platform , with
ming/msys environment , but I cannot get it with this task , I googled this
problem and tried to figure out where is the problem , but i cannot . I
guess is not a problem with the mingw environment /compiler , had seen many
post with patches for cryptoapi.c , and well , I want to know if the problem
is located in my computer /installation or may be is there's a chance that
something in the source is not working properly, and is there a solution.

This is what I'm facing when tried to compile openvpn ( using prebuilds ! )


cryptoapi.c:55 error: 'CryptoAcquireCertificatePrivateKey' redeclared as
different kind of symbol
c:/MinGW/bin/../lib/gcc/mingw32/3.4.5/../../../../include/wincrypt.h:1298:
error: previous declaration of 'CryptAcquireCertificatePrivateKey' was here
cryptoapi.c:55 error: 'CryptoAcquireCertificatePrivateKey' redeclared as
different kind of symbol
c:/MinGW/bin/../lib/gcc/mingw32/3.4.5/../../../../include/wincrypt.h:1298:
error: previous declaration of 'CryptAcquireCertificatePrivateKey' was here
make[2]: ***[cryptoapi.o] Error 1
make[2]: *** Waiting for unfinished jobs ....
make[2]: Leaving directory
`/c/Download/openvpn-2.1_rc13-prebuild/openvpn-2.1_rc13'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory
`/c/Download/openvpn-2.1_rc13-prebuild/openvpn-2.1_rc13'
make: *** [all] Error 2

Thanks in advance for any help or solution

------=_Part_11645_29608003.1232485213748
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi guys<br><br>&nbsp;I&#39;m trying to compile openvpn-2.1_rc1[3-5] in a WIN platform , with ming/msys environment , but I cannot get it with this task , I googled this problem and tried to figure out where is the problem , but i cannot . I guess is not a problem with the mingw environment /compiler , had seen many post with patches for cryptoapi.c , and well , I want to know if the problem is located in my computer /installation or may be is there&#39;s a chance that something in the source is not working properly, and is there a solution.<br>
<br>This is what I&#39;m facing when tried to compile openvpn ( using prebuilds ! )<br><br><br>cryptoapi.c:55 error: &#39;CryptoAcquireCertificatePrivateKey&#39; redeclared as different kind of symbol <br>c:/MinGW/bin/../lib/gcc/mingw32/3.4.5/../../../../include/wincrypt.h:1298:
error: previous declaration of &#39;CryptAcquireCertificatePrivateKey&#39; was
here <br>cryptoapi.c:55 error: &#39;CryptoAcquireCertificatePrivateKey&#39; redeclared as different kind of symbol <br>c:/MinGW/bin/../lib/gcc/mingw32/3.4.5/../../../../include/wincrypt.h:1298:
error: previous declaration of &#39;CryptAcquireCertificatePrivateKey&#39; was
here <br>make[2]: ***[cryptoapi.o] Error 1 <br>make[2]: *** Waiting for unfinished jobs ....<br>make[2]: Leaving directory `/c/Download/openvpn-2.1_rc13-prebuild/openvpn-2.1_rc13&#39;<br>make[1]: *** [all-recursive] Error 1<br>
make[1]: Leaving directory `/c/Download/openvpn-2.1_rc13-prebuild/openvpn-2.1_rc13&#39;<br>make: *** [all] Error 2<br><br>Thanks in advance for any help or solution<br><br>&nbsp; <br>

------=_Part_11645_29608003.1232485213748--

