Message-ID: <1074258663.4007e2e739a70@...156...>
From: Robin Wenninger <robin@...152...>
Subject: Re: [Openvpn-devel] OpenVPN 1.5.0 -> write UDPv4 []: No buffer space available
References: <twig.1073984885.27254@...41...>
In-Reply-To: <twig.1073984885.27254@...41...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ107425866371e560262d14fa49ec8134e426a7457e"
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
Date: Fri Jan 16 05:12:01 2004
To: James Yonan <jim@...41...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This message is in MIME format.

---MOQ107425866371e560262d14fa49ec8134e426a7457e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hi James,

I was busy last week - sorry for the late answer... 


Zitat von James Yonan <jim@...41...>:

> "Robin G. Wenninger" <robin@...152...> said:
> 
> > Hi List,
> > 
> > I'm not sure about if this is a real bug, but:
> > 
> > Since OpenVPN 1.5.0 I notice this in my log-files:
> > 
> > <snip>
> > Jan 12 16:55:14 hefti openvpn[20762]: write UDPv4 []: No buffer space
> > available (code=105)
> > Jan 12 16:56:04 hefti last message repeated 4 times
> > Jan 12 16:56:21 hefti last message repeated 3 times
> > 
> > (the same with "ping -s 1000 -f")
> > Jan 12 21:18:46 hefti last message repeated 976 times
> > <snap> ...and so on
> > 
> > First I thought it might be a Kernel problem, but I get these error
> > under 2.4.20, 2.4.23, 2.6.1 and also this happens only since OVPN
> > 1.5.0.
> > 
> > It's very easy to reproduce if you try something like
> > "ping -s 1000" or even "ping -s 1000 -f" over the tunnel. However I 
> > don't assume that this has a major effect to the throughput but I'm 
> > wondering about this message.
> 
> ping -s 1000 works fine for me.  What do the config files look like?  It may
> be the case that the mtu, fragment, or mssfix parms are not set correctly.
> 
> James

I used the default config files and only uncommented some stuff, but I will
attach them...

If you need it I can send you the ifconfig-ouput (MTU and so on), but I also
played around with them before.

Thanks a lot.

Robin

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.

---MOQ107425866371e560262d14fa49ec8134e426a7457e
Content-Type: application/gzip; name="openvpn-config.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="openvpn-config.tar.gz"

H4sIAEDiB0AAA+1W227cNhD1837FwH5wC1iq5PV6UeTVTREgqAMYzkPeuFpqlzBFqrzsJV/fM5TW
txgNAsQJivLAgKXlzHAuZ0bjgwiqKda2k2VjTXv0Cqjqqrq8uDiqBjz/Pz2v50cQqer5ZTWfzyF/
fjmrj6h6DWeeI/ogHNGRszb8m9zXzv+jOJmc0I3oei3pupfm44e/iGmgVtGBGNZQq3DUWgc5JglF
r8yKBPVOFn4tnFySTxyiO7kvJ2zv9OSUrKPTN6fUiT0tWAliwdJSatWpgCu6TprgywnEb72EveXe
iA5WQjQQ26hGwhi9hZ33ysQdnZfnbNRYUww/XN9IfwaRvY3pmq0wge+IbM6Q3PVaNSpAIhpcaWK3
kI58bNYkPB3jnvqYrziELbS3OO5764KnjXIhCo1zGdbSGRmgIvrj0Td4jgd2dnLSO4trQ9MXjVaI
imO6ju7ecC9xr/IEO2TbFtq0EkFuBdLlZGeDJHRAudsNf6xeV2VdVogYahamtG2EJjYmzbK3CpH+
wtX4tXwQrg/Co82n0sPFkFftUN9B7ZwvOTzVB89jT75xqg+0VVqTRIEXWvk1ORuD9JCyBlFwQHwL
7hVabVAwKJa/pVkS+4OxF4ky8bJxyGlc2pJfH9UB9fN0e/WBuBA0w1ygxR5pb0XUgeP9Q6CEB2lU
wEhNHdqYNXEMKqm2lQ6VGEwMlWdNnd7BIpceGtBkJCcOEz0NZ+6pPocL/o81EGY5JricvHlwkQO4
sluzcmIp6fbdVRL8E/+DxdGxsQu73B+TaAOTAYRUSNnn1GKjfbkLThDyEp0Ke7YOx5jwrIm3FZLf
H16h865N1F9EpcN9OrYqrHH2/tM19xhS7z1uOEMLjC3HtYshla61Wtstd7NWBuEkjUJ/tmz9BtRB
KlMdWATZGXnFpee22Ei3p3rGHluz9CxxJ2WPIy6zbKPG7HCgORgECSObMdiBK0S3B5/gjfKjY2qI
CnS5nzQHc5yn0WDKPZ/WszRBnlhij4bRhawK6ixsOQwecBi1lWE83a6lYet7H2TH5LBMPIXef/AW
Xr5NpUkT8gzMELqIvWcOadEH23NbC84qircBEZEFywMj0YVNYFIMrk6r4aFw3E/gDT554y9BddLh
9w7v0nnlQ8GT5f5l7BD8VnQhsmIi3EfpFtaDLKRRDc0Mr6go6O+o0Fpy10h0MCehFQHUlc5Z59PE
YKnO+qD3g/AZaBQQne81JinP2EEFY29r3d0j1WlSlUsVO65XH6G7snaZ7jHWddCy8DvFzgq/s8Im
eSofiQawGfXwa3xWkYIJS9B08rM/h/87DCO5GD4Pr7QBfm3/qy7rtP9V1Xx6cTmD/LSezvP+9yPw
LfvfuLzkDfDZBvjCDvbSwna/gn253724so0L3hcLW/2wun2fhW1s/ryy5ZUtr2yPVza4+nRlu5h9
28aWN7SMjIyMjIyMjIyMjIyMjIyMjIyMjIyfg38AZ40bhAAoAAA=

---MOQ107425866371e560262d14fa49ec8134e426a7457e--


