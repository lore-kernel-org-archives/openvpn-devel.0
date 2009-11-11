MIME-Version: 1.0
In-Reply-To: <4AFA9AA7.4030600@...260...>
References: <20091110161632.GA31301@...1276...> 
	<4AFA789B.4070607@...1114...>
	<20091111102515.GA19782@...1066...> <4AFA9AA7.4030600@...260...>
From: Jonathan Petersson <jpetersson@...1214...>
Date: Wed, 11 Nov 2009 12:20:31 +0100
Message-ID: <fa2e1350911110320g2f1b0a97ke366d1d55a29f906@...278...>
Subject: Re: [Openvpn-devel] Script interface to trigger events depending on
	the validity of a certificate
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mathieu GIANNECCHINI <mat.giann@...260...>
Cc: openvpn-devel@lists.sourceforge.net

This may not be a preferable approach but it should do the trick for you.

Upon connection the OpenVPN client reports it's common_name through
environmental variables: "The X509 common name of an authenticated
client. Set prior to execution of --client-connect,
--client-disconnect, and --auth-user-pass-verify scripts."

As it's doing this you can trigger a client-connect script to retrieve
the "Validity Not After" data from the client-cert (if you have a
local copy on the server) if the time-frame is out of realms trigger
sendmail or preferable mail-daemon to send an email to you or the user
notifying about renewing the certificate.

Good luck!

/Jonathan

On Wed, Nov 11, 2009 at 12:06 PM, Mathieu GIANNECCHINI
<mat.giann@...260...> wrote:
> Victor Wagner a =E9crit :
>> On 2009.11.11 at 09:40:59 +0100, David Sommerseth wrote:
>>
>>
>>> On 10/11/09 17:16, Till Maas wrote:
>>>
>>>> I would like to get a notification in case a client certificate is used
>>>> for a connection to an OpenVPN server, that is about to expire soon. Is
>>>> there currently a way to do this? I looked into the tls-verify hook, b=
ut
>>>> according to the documentation, only the Subject line of a certificate
>>>> is available and not the validity. Is there maybe a way to log the
>>>> expiration dates?
>>>>
>>> I don't think this is possible without patching openvpn to put these
>>> values into some environment variables for the --tls-verify hook. =A0I'=
ve
>>> done something similar in regards to the SHA1 fingerprint for my own
>>> project (I have had an OpenVPN patch pending since RC7). =A0But I'd be
>>> willing to carry such a feature in my eurephia patch for OpenVPN, as
>>> that sounds very useful.
>>>
>>
>> Apache/mod_ssl does export entire certificate in the PEM format as
>> environment variable. So, may be openvpn sould do the same?
>>
>> Now various people patching openvpn to add some values:
>> you've added sha1 fingerprint, I've added certificate extension
>> subjectAltName, et cetera, et cetera.
>>
>> But if entire certificate would be available, it would be possible to
>> extract any information from it (or hash it with any algorithm) from the
>> script using openssl command line utility or some binding or OpenSSL
>> libraries to the choosen script language.
>>
>
> Ok, i try once again. Maybe the solution is here :
> http://article.gmane.org/gmane.network.openvpn.devel/2492
>
>
> -------------------------------------------------------------------------=
-----
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-D=
ay
> trial. Simplify your report design, integration and deployment - and focu=
s on
> what you do best, core application coding. Discover what's new with
> Crystal Reports now. =A0http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

