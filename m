MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Sun, 25 Nov 2012 18:51:09 -0500
Message-ID: <CAKuzo_gp71_rgRa6gMjQHsFb+T8Zkfqp44u+oMm_Zt=EB5Ej9Q@...278...>
Content-Type: multipart/alternative; boundary=bcaec554d8e4e08e3404cf5a7e00
Subject: [Openvpn-devel] private key from management-interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--bcaec554d8e4e08e3404cf5a7e00
Content-Type: text/plain; charset=UTF-8

Hi,

I am implementing a VPN setup using OpenVPN for a few users most of who use
Windows and the server also has to run on Windows. I can't have users
running openvpn with root privilege so I've settled on using the service
option with a management-interface client running with limited user rights.

I would prefer client keys and certificates handled at the user level with
no need for admin privilege to store and replace certificates.
Cryptoapicert option works only if the certificate/key are in the system
store (not user store). So I am thinking of using the
management-external-key option available on 2.3. It currently supports only
getting the private key from the MI which is kind of limiting so I have
added code to take certificate as well through the MI (patches available if
its of interest to others/developers).

So here is my question: is there any issues that I should be aware of when
the certificate and key (actually not key, only rsa-signature) are provided
from the UI? AFAICS TLS erros are not reported back to the management so
users using wrong certificates or keys could lead to some flakiness of the
whole setup?

I use a patched version of OpenVPN MI GUI with certificate and key stored
in windows certificate store (under user) and accessed by cryptoapi calls
from the UI. One nice thing about this is hardware tokens also would work
which is otherwise hard/impossible with OpenVPN running as a service.

Any comments would be greatly appreciated.

Selva

--bcaec554d8e4e08e3404cf5a7e00
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I am implementing a VPN setup using OpenVPN for a few users most=
 of who use Windows and the server also has to run on Windows. I can&#39;t =
have users running openvpn with root privilege so I&#39;ve settled on using=
 the service option with a management-interface client running with limited=
 user rights.<br>


<br>I would prefer client keys and certificates handled at the user level w=
ith no need for admin privilege to store and replace certificates. Cryptoap=
icert option works only if the certificate/key are in the system store (not=
 user store). So I am thinking of using the management-external-key option =
available on 2.3. It currently supports only getting the private key from t=
he MI which is kind of limiting so I have added code to take certificate as=
 well through the MI (patches available if its of interest to others/develo=
pers).<br>


<br>So here is my question: is there any issues that I should be aware of w=
hen the certificate and key (actually not key, only rsa-signature) are prov=
ided from the UI? AFAICS TLS erros are not reported back to the management =
so users using wrong certificates or keys could lead to some flakiness of t=
he whole setup?<br>


<br>I use a patched version of OpenVPN MI GUI with certificate and key stor=
ed in windows certificate store (under user) and accessed by cryptoapi call=
s from the UI. One nice thing about this is hardware tokens also would work=
 which is otherwise hard/impossible with OpenVPN running as a service.<br>


<br>Any comments would be greatly appreciated.<br><br>Selva<br>=C2=A0<br>

--bcaec554d8e4e08e3404cf5a7e00--

