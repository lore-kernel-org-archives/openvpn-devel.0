Date: Sat, 16 Sep 2006 17:22:54 -0400
From: Mike Martin <Mike.Martin@...777...>
In-reply-to: <9e0cf0bf0609161341n286986d8i4a39a8cab4d59a5c@...278...>
Message-id: <450C6B2E.9040107@...777...>
MIME-version: 1.0
References: <450C6060.6060605@...777...>
	<9e0cf0bf0609161341n286986d8i4a39a8cab4d59a5c@...278...>
Subject: Re: [Openvpn-devel] request for input re: OpenVPN API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: OpenVPN Developers <openvpn-devel@lists.sourceforge.net>

Thanks for the quick response,

I have been looking at the management interface as a tool for this API.=20
But I am new to OpenVPN, and I am not sure if it has all the essentials=20
at this stage to qualify as a full-blown interface, or if it is a tool=20
in development. I thought maybe I could be enlightened here.

I have found that an API is a nebulous concept. It is quite difficult to=20
find a concrete definition. Here is how I have decided to define an API=20
in my paper, using API design material provided by the Netbeans site=20
(there is remarkably little written about how to go about designing an=20
API. I suspect it is one of those things that is so intrinsic to what=20
programmers do, that they don't often stop to think about it. Maybe it's=20
only a topic for academics):

=93The API is everything that another team or application can depend on.=94=
=20
Also, it can be seen as an =93interface between the internals of an=20
application and a programatic (sic) usage of its functionality=94.=20
(Netbeans) To be more specific, the everything mentioned above includes=20
method and field signatures, files and file content, environment=20
variables, protocols, program behaviour, and localization issues=20
(regarding culture and language, often referred to as L10n)

I was hoping to get feedback from OpenVPN developers about what kinds of=20
controls/communications/data flow would be necessary between the OpenVPN=20
software and a program trying to automatically maintain VPN connections=20
over an extended period of time. I have been looking through the source=20
code, trying to piece together the method and field signatures, files=20
and file content, env vars.etc., with some success, but I thought some=20
feedback from those who know it intimately might help me decide what are=20
the vital bits of functionality which should be accessible to an=20
interface with this other program, and where in the source code to look.=20
The ssl.h header file has been good to me in terms of understanding=20
security protocols. I am looking through others at the moment. I have=20
some ideas, but I'm new here, and was hoping to draw on some willing=20
expertise. Perhaps the management interface does contain all that is=20
necessary. My research in API design suggests that it is best to start=20
small - get only the absolutely necessary interface components defined=20
first, and then add carefully with experience. It is easy to add to an=20
API, it is impossible to remove. So the question is, what are the bare=20
essentials for another program to interface with OpenVPN, and where can=20
their implementation be found in the source code? I thought the=20
perspective of developers would make for some valuable research, hence=20
my email.

Is that any more clear? Anyway, Once again, any feedback is welcome. If=20
this is an unwelcome discussion, please let me know, and I'll quietly go=20
back to lurking.

Thanks again,

Mike

Alon Bar-Lev wrote:
> I don't understand what you are calling an API, but please refer to:
> http://svn.openvpn.net/projects/openvpn/trunk/openvpn/management/manageme=
nt-notes.txt
>
> Maybe it will answer some of your questions.
>
> On 9/16/06, Mike Martin <Mike.Martin@...777...> wrote:
>=20=20=20
>> Hello,
>>
>> My name is Mike Martin, and I am currently working on my M. Sc. I am
>> writing a research paper investigating the feasibility of developing an
>> API for a VPN, as discussed in the following quote:
>>
>> "It would be nice if the Grid application could access the VPN console,
>> re-affirm credentials, and register for notifications through an API
>> like the GSS or the Advance Reservation API listed above."
>> -Volker Sander (ed.) (2004) /Networking Issues for Grid Infrastructure/.
>> Global Grid Forum Document Series GFD-37. Available from:
>> http://www.ggf.org/documents/GFD.37.pdf
>>
>> I started this knowing very little about VPNs, or about API design, but
>> my research has led me to believe that OpenVPN would be the best tool
>> for the job (I am a firm believer in Open Source Software). I am
>> wondering if any OpenVPN developers would be willing to fill out a short
>> (from my perspective) questionnaire regarding the requirements for such
>> an API for OpenVPN, either for Grid applications specifically, or for
>> any client application in general, as I have come to the conclusion that
>> an API should not be specific to the client application, but should be
>> as general as possible. Any help at all would be greatly appreciated.
>>
>> If anyone is interested in participating, please email me off line so we
>> don't clutter your mailing list - unless there is such great interest
>> you would like to see it in the discussion.
>>
>> I am a professor of Computer Studies at Seneca College in Toronto:
>> mike.martin@...777...
>>
>> Thanks, you guys have created a great piece of software,
>>
>> Mike
>>
>> P.S. We are having our annual Open Source Software Conference in
>> October. Here is the url:
>> http://cs.senecac.on.ca/fsoss/2006/
>>
>> It would be good to see OpenVPN people there. Next year I would like to
>> do a presentation about OpenVPN, because I am getting so tired of
>> everyone thinking IPSec is the only high quality VPN technology. They
>> all suffer from the same misconceptions about SSL VPNs that are
>> discussed by Charlie Hosner in his SANS paper. I feel like a prophet
>> lost in the wilderness.
>>
>>
>>
>>
>> -------------------------------------------------------------------------
>> Using Tomcat but need to do more? Need to support web services, security?
>> Get stuff done quickly with pre-integrated technology to make your job e=
asier
>> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geroni=
mo
>> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>>=20=20=20=20=20
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job ea=
sier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20=20=20



