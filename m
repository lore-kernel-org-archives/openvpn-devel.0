Message-ID: <4AFA9AA7.4030600@...260...>
Date: Wed, 11 Nov 2009 12:06:15 +0100
From: Mathieu GIANNECCHINI <mat.giann@...260...>
MIME-Version: 1.0
References: <20091110161632.GA31301@...1276...>	<4AFA789B.4070607@...1114...>
	<20091111102515.GA19782@...1066...>
In-Reply-To: <20091111102515.GA19782@...1066...>
Subject: Re: [Openvpn-devel] Script interface to trigger events depending
 on	the validity of a certificate
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Victor Wagner a =C3=A9crit :
> On 2009.11.11 at 09:40:59 +0100, David Sommerseth wrote:
>
>=20=20=20
>> On 10/11/09 17:16, Till Maas wrote:
>>=20=20=20=20=20
>>> I would like to get a notification in case a client certificate is used
>>> for a connection to an OpenVPN server, that is about to expire soon. Is
>>> there currently a way to do this? I looked into the tls-verify hook, but
>>> according to the documentation, only the Subject line of a certificate
>>> is available and not the validity. Is there maybe a way to log the
>>> expiration dates?
>>>=20=20=20=20=20=20=20
>> I don't think this is possible without patching openvpn to put these
>> values into some environment variables for the --tls-verify hook.  I've
>> done something similar in regards to the SHA1 fingerprint for my own
>> project (I have had an OpenVPN patch pending since RC7).  But I'd be
>> willing to carry such a feature in my eurephia patch for OpenVPN, as
>> that sounds very useful.
>>=20=20=20=20=20
>
> Apache/mod_ssl does export entire certificate in the PEM format as
> environment variable. So, may be openvpn sould do the same?
>
> Now various people patching openvpn to add some values:
> you've added sha1 fingerprint, I've added certificate extension
> subjectAltName, et cetera, et cetera.
>
> But if entire certificate would be available, it would be possible to
> extract any information from it (or hash it with any algorithm) from the
> script using openssl command line utility or some binding or OpenSSL
> libraries to the choosen script language.
>=20=20=20

Ok, i try once again. Maybe the solution is here :
http://article.gmane.org/gmane.network.openvpn.devel/2492


