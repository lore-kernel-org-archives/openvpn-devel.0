From: Abdullah Alshalan <aalshala@...1837...>
Message-Id: <D9FC2C20-7EBE-4C8E-98DF-A48BE87936C4@...1837...>
Date: Thu, 19 Dec 2013 18:56:19 -0700
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: [Openvpn-devel] question about openvpn_ethhdr and openvpn_iphdr
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,
I've been working on modifying openvpn code for certain requirements I wann=
a implement and I'm running into a few problems which I hope someone in thi=
s mailing list could help me with or just give me some insight about them.

I tried to print out the ethernet and IP headers of the packets in the inco=
ming_tun buffer. The methods that does the printing is mentioned below.
I run the modified openvpn code and established a VPN tunnel.. I establishe=
d an FTP connection between machine A (running openvpn client and ftp clien=
t ) tun ip is 10.0.8.2 and machine B running FTP server whose IP is 10.0.0.=
2.

The printed packet info showed incorrect mac addresses, incorrect SRC and D=
EST IPs.The only thing that was printed correctly was the IP protocol. it's=
 always showing 20 or 21.
What amazes me even more is the values of ih->saddr and ih->daddr has been =
uniquely different for every printed packet! I was expecting to only see to=
 values representing those IPs only 10.0.8.2  and 10.0.0.2.
I don't know what I did wrong but if anyone can look at the code I wrote an=
d see if I did anything wrong.=20

Some RESULTS of RUNNING THE CODE:

ETHERNET PROTOCOL :[unknown protocol]
MAC SRC: 40:0:40:6:c1:f9
MAC DEST: 45:8:0:34:64:b3
Source IP using inet_ntop: 18.150.151.187
Source IP in decimal representation =3D 3147273746
Dest IP using inet_ntop: 187.250.128.17
Dest IP in decimal representation =3D 293665467
IP Protocol =3D 20

ETHERNET PROTOCOL :[unknown protocol]
MAC SRC: 40:0:40:6:ae:39
MAC DEST: 45:10:0:34:78:6b
Source IP using inet_ntop: 16.163.150.188
Source IP in decimal representation =3D 3163988752
Dest IP using inet_ntop: 19.77.128.16
Dest IP in decimal representation =3D 276843795
IP Protocol =3D 21



CODE:

process_incoming_tun (struct context *c)
{
....

 if (c->c2.buf.len > 0)
    {
	printipv4packet(&c->c2.buf);=20
	.....

}


void printipv4packet(struct buffer *buf)=20
{=20
    // PRINT ALL MAC LAYER INFORMATION
    const struct openvpn_ethhdr *eh;
    eh =3D (const struct openvpn_ethhdr *) BPTR (buf);=20

    printf("\nETHERNET PROTOCOL :%s\n", ethProtcol2Ascii(eh->proto));=20
    printf("MAC SRC: %x:%x:%x:%x:%x:%x\n", eh->source[0], eh->source[1], eh=
->source[2], eh->source[3], eh->source[4], eh->source[5]);=20
    printf("MAC DEST: %x:%x:%x:%x:%x:%x\n", eh->dest[0], eh->dest[1], eh->d=
est[2], eh->dest[3], eh->dest[4], eh->dest[5]);=20

    // PRINT ALL IP LAYER INFORMATION (if applicable)

    if (BLEN (buf) >=3D (int)(sizeof (struct openvpn_ethhdr) + sizeof (stru=
ct openvpn_iphdr)))=20
    {
        int ipPacketOffset =3D sizeof (struct openvpn_ethhdr);=20
        const struct openvpn_iphdr *ih;=20
        ih =3D (const struct openvpn_iphdr *) (BPTR (buf) + ipPacketOffset)=
;=20
        printf("SRC ");=20
	char str[INET_ADDRSTRLEN];=09
	inet_ntop(AF_INET, &ih->saddr, str, INET_ADDRSTRLEN);
	printf("Source IP using inet_ntop: %s\n", str);
	printf("Source IP in decimal representation =3D %u\n", ih->saddr);=20=20=
=20=20
	printf("DEST ");=20
	inet_ntop(AF_INET, &ih->daddr , str, INET_ADDRSTRLEN);
	printf("Dest IP using inet_ntop: %s\n", str);
	printf("Dest IP in decimal representation =3D %u\n", ih->daddr);=20
        printf("IP Protocol =3D %u\n", ih->protocol);=20
    }=20
}=20


I appreciate any insight!
Thank you
Abdullah


